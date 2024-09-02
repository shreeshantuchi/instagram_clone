import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DynamicImageFit extends StatefulWidget {
  final String imageUrl;

  const DynamicImageFit({super.key, required this.imageUrl});

  @override
  // ignore: library_private_types_in_public_api
  _DynamicImageFitState createState() => _DynamicImageFitState();
}

class _DynamicImageFitState extends State<DynamicImageFit> {
  late Image _image;
  double? _imageWidth;
  double? _imageHeight;
  bool _imageLoaded = false;
  bool _widthDominated = true;
  late ImageStreamListener _listener;
  late ImageStream _stream;

  @override
  void initState() {
    super.initState();
    _image = Image.network(widget.imageUrl);
    _stream = _image.image.resolve(const ImageConfiguration());
    _listener = ImageStreamListener((ImageInfo info, bool _) {
      if (mounted) {
        setState(() {
          _imageWidth = info.image.width.toDouble();
          _imageHeight = info.image.height.toDouble();
          _imageLoaded = true;
          if (_imageWidth != null && _imageHeight != null) {
            _widthDominated = _imageWidth! > _imageHeight!;
          }
        });
      }
    });

    _stream.addListener(_listener);
  }

  @override
  void dispose() {
    _stream.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _imageLoaded
        ? Container(
            width: _widthDominated ? 220 : 120,
            height: _widthDominated ? 120 : 220,
            child: FittedBox(
              fit: _widthDominated ? BoxFit.fitWidth : BoxFit.fitHeight,
              child: _image,
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 300.0,
              height: 220.0,
              color: Colors.white,
            ),
          );
  }
}
