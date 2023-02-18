// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class PeopleLovedCardWidget extends StatelessWidget {
  final String fullName;
  final String age;
  final String occupation;
  final String? imagePath;
  final String bio;

  const PeopleLovedCardWidget({
    Key? key,
    required this.fullName,
    required this.age,
    required this.occupation,
    this.imagePath,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppMargin.m20,
        0.0,
        AppMargin.m20,
        AppMargin.m18,
      ),
      decoration: BoxDecoration(
        color: ColorManager.secondary,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppPadding.p10),
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                imagePath!,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          fullName,
          style: getWhiteTextStyle(
            fontSize: FontSizeManager.f20,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        subtitle: Text(
          '$age, $occupation',
          style: getGrey60TextStyle(),
        ),
      ),
    );
  }
}
