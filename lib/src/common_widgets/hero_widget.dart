import 'package:flutter/material.dart';
import 'package:sarang_app/src/theme_manager/asset_image_icon_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 215.0,
      margin: const EdgeInsets.symmetric(
        vertical: AppMargin.m30,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            '${AssetImageIconManager.imagePath}/hero_image.png',
          ),
        ),
      ),
    );
  }
}
