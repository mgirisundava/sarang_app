// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:sarang_app/src/common_widgets/image_view_widget.dart';

class ImageViewScreen extends StatelessWidget {
  static const routeName = '/image-view';
  const ImageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var image = ModalRoute.of(context)!.settings.arguments as ImageViewArgs;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ImageViewWidget(
        fileImage: image.fileImage != null ? image.fileImage! : null,
        imagePath: image.imagePath != null ? image.imagePath! : null,
      ),
    );
  }
}

class ImageViewArgs {
  final File? fileImage;
  final String? imagePath;

  ImageViewArgs({
    this.fileImage,
    this.imagePath,
  });
}
