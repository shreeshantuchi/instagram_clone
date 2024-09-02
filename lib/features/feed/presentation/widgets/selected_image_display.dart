import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/features/feed/presentation/image_state.dart';
import 'package:provider/provider.dart';

class SelectedImageDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageState>();

    return ValueListenableBuilder<Uint8List?>(
      valueListenable: imageState.selectedImage,
      builder: (context, imageData, child) {
        return imageData != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.memory(
                    imageData,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                color: Colors.grey[200],
                child: Center(
                  child: Text('No Image Selected'),
                ),
              );
      },
    );
  }
}
