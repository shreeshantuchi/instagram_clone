import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageStack extends StatelessWidget {
  final List<XFile> imageFiles;

  const ImageStack({super.key, required this.imageFiles});

  @override
  Widget build(BuildContext context) {
    int imageCount = imageFiles.length;

    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
          children: List.generate(imageCount > 3 ? 3 : imageCount, (index) {
        return Positioned(
          left: index * 20.0, // Adjust this value for separation
          child: Opacity(
            opacity: 1.0 - index * 0.2, // Adjust this value for opacity
            child: Image.file(
              File(imageFiles[index].path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        );
      })
          // ..add(
          //   imageCount > 3
          //       ? Positioned(
          //           left: 3 * 20.0, // Adjust this value for separation
          //           child: Container(
          //             width: 100,
          //             height: 100,
          //             color: Colors.grey.withOpacity(0.7),
          //             child: Center(
          //               child: Text(
          //                 '+${imageCount - 3}',
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 24,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         )
          //       : Container(
          //           color: Colors.red,
          //         ),
          // ),
          ),
    );
  }
}
