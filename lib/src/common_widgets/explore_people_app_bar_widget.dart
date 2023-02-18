import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/logo_widget.dart';
import 'package:sarang_app/src/features/authentication/domain/user_account_model.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_loved_screen.dart';
import 'package:sarang_app/src/features/user/presentation/user_profile_screen.dart';
import 'package:sarang_app/src/helpers/layout_helper.dart';
import 'package:sarang_app/src/theme_manager/asset_image_icon_manager.dart';

class ExplorePeopleAppBarWidget extends StatelessWidget {
  final UserAccountModel? userAccount;

  const ExplorePeopleAppBarWidget({super.key, required this.userAccount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TouchableOpacity(
          onTap: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.pushNamed(
              context,
              UserProfileScreen.routeName,
              arguments: userAccount,
            );
          },
          child: Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: userAccount?.image != null
                    ? FileImage(File(userAccount!.image!))
                    : const AssetImage(
                        '${AssetImageIconManager.imagePath}/profile_icon.png',
                      ) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const LogoWidget(),
        TouchableOpacity(
          onTap: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.pushNamed(context, PeopleLovedScreen.routeName);
          },
          child: Container(
            width: 24.0,
            height: 24.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  '${AssetImageIconManager.imagePath}/icon_notification.png',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
