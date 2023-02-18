import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';

class ImageViewWidget extends StatelessWidget {
  final File? fileImage;
  final String? imagePath;

  const ImageViewWidget({
    super.key,
    this.fileImage,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PhotoView(
        imageProvider: fileImage != null
            ? FileImage(fileImage!)
            : AssetImage(imagePath!) as ImageProvider,
        backgroundDecoration: BoxDecoration(
          color: ColorManager.primary,
        ),
      ),
    );
  }
}
