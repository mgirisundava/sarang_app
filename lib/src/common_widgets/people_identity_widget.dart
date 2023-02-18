// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class PeopleIdentityWidget extends StatelessWidget {
  final String fullname;
  final String age;
  final String occupation;
  final String? bio;
  const PeopleIdentityWidget({
    Key? key,
    required this.fullname,
    required this.age,
    required this.occupation,
    this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fullname,
            style: getWhiteTextStyle(
              fontSize: FontSizeManager.f28,
              fontWeight: FontWeightManager.semiBold,
            ),
          ),
          Text(
            '$age, $occupation',
            style: getBlackTextStyle(),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            bio ?? '-',
            style: getWhiteTextStyle(),
          ),
        ],
      ),
    );
  }
}
