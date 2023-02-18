// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_screens/image_view_screen.dart';
import 'package:sarang_app/src/helpers/layout_helper.dart';
import 'package:sarang_app/src/theme_manager/asset_image_icon_manager.dart';

class ProfileDetailImageWidget extends StatelessWidget {
  final File? fileImage;
  final String? imagePath;

  const ProfileDetailImageWidget({
    Key? key,
    this.fileImage,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getProfilePicture() {
      if (fileImage != null) {
        return FileImage(File(fileImage!.path));
      } else if (fileImage == null) {
        if (imagePath != null) {
          return AssetImage(imagePath!);
        } else {
          return const AssetImage(
            '${AssetImageIconManager.imagePath}/profile_icon.png',
          );
        }
      } else {
        return const AssetImage(
          '${AssetImageIconManager.imagePath}/profile_icon.png',
        );
      }
    }

    return TouchableOpacity(
      onTap: () {
        if (fileImage != null) {
          Navigator.pushNamed(
            context,
            ImageViewScreen.routeName,
            arguments: ImageViewArgs(
              fileImage: fileImage,
            ),
          );
        } else if (imagePath != null) {
          Navigator.pushNamed(
            context,
            ImageViewScreen.routeName,
            arguments: ImageViewArgs(
              imagePath: imagePath,
            ),
          );
        } else {
          null;
        }
      },
      child: Container(
        width: double.infinity,
        height: 420.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: getProfilePicture() as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
