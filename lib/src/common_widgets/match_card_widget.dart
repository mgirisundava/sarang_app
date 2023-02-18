// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sarang_app/src/common_widgets/glass_card_widget.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_model.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_profile_screen.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';

class MatchCardWidget extends StatelessWidget {
  final UserModel userData;

  const MatchCardWidget({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        Navigator.pushNamed(
          context,
          PeopleProfileScreen.routeName,
          arguments: userData,
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  userData.imagePath ?? '',
                ),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                width: 10.0,
                color: ColorManager.secondary,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(70.0),
            ),
          ),
          GlassCardWidget(
            fullName: userData.fullName,
            age: userData.age,
            occupation: userData.occupation,
          ),
        ],
      ),
    );
  }
}
