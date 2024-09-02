import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:login_token_app/features/feed/presentation/image_state.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class ImageGrid extends StatefulWidget {
  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  @override
  void initState() {
    context.read<ImageState>().fetchImages();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageState>();

    return ValueListenableBuilder<List<AssetEntity>?>(
      valueListenable: imageState.mediaList,
      builder: (context, mediaList, child) {
        return mediaList != null
            ? mediaList.isNotEmpty
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      crossAxisCount: 4,
                    ),
                    itemCount: mediaList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () =>
                            imageState.selectImage(mediaList[index], index),
                        child: FutureBuilder<Uint8List?>(
                          future:
                              imageState.getThumbnail(index, mediaList[index]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
                              return ValueListenableBuilder<int?>(
                                valueListenable: imageState.selectedIndex,
                                builder: (context, selectedIndex, child) {
                                  return Opacity(
                                    opacity: selectedIndex == index ? 0.5 : 1.0,
                                    child: Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Container(
                                color: Colors.grey[200],
                              );
                            }
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No Photos available"),
                  )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
