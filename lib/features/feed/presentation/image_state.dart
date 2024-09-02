import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageState with ChangeNotifier {
  final ValueNotifier<List<AssetEntity>?> mediaList =
      ValueNotifier<List<AssetEntity>?>(null);
  final ValueNotifier<Uint8List?> selectedImage =
      ValueNotifier<Uint8List?>(null);
  final ValueNotifier<int?> selectedIndex = ValueNotifier<int?>(null);
  final ValueNotifier<String?> selectedImagePath = ValueNotifier<String?>(null);

  final Map<int, Uint8List?> _thumbnailCache = {}; // Cache for thumbnails

  ImageState() {
    fetchImages();
  }

  Future<void> fetchImages() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: FilterOptionGroup(
          imageOption: FilterOption(
            sizeConstraint: SizeConstraint(minWidth: 100, minHeight: 100),
          ),
          orders: [OrderOption(type: OrderOptionType.createDate, asc: false)],
        ),
      );
      List<AssetEntity>? media;
      if (albums.isNotEmpty) {
        media = await albums.first.getAssetListPaged(page: 0, size: 100);
      }

      mediaList.value = media;
      print(media);
      if (mediaList.value != null) {
        selectImage(mediaList.value!.first, 0);
      }
    } else {
      PhotoManager.openSetting();
    }

    notifyListeners();
  }

  Future<void> selectImage(AssetEntity asset, int index) async {
    if (!_thumbnailCache.containsKey(index)) {
      final Uint8List? imageData = await asset.thumbnailDataWithSize(
        ThumbnailSize(800, 800),
      );
      _thumbnailCache[index] = imageData;
    }

    final File? file = await asset.file;
    if (file != null) {
      selectedImagePath.value = file.path;
      print('Selected image path: ${selectedImagePath.value}');
    }

    selectedImage.value = _thumbnailCache[index];
    selectedIndex.value = index;
  }

  Future<Uint8List?> getThumbnail(int index, AssetEntity asset) async {
    if (_thumbnailCache.containsKey(index)) {
      return _thumbnailCache[index];
    } else {
      final Uint8List? thumbnail =
          await asset.thumbnailDataWithSize(ThumbnailSize(200, 200));
      _thumbnailCache[index] = thumbnail;
      return thumbnail;
    }
  }

  @override
  void dispose() {
    mediaList.dispose();
    selectedImage.dispose();
    selectedIndex.dispose();
    selectedImagePath.dispose();
    super.dispose();
  }
}
