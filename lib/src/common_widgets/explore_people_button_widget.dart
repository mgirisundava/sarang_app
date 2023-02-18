// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';

import 'package:sarang_app/src/common_widgets/match_button_widget.dart';

class ExplorePeopleButtonWidget extends StatelessWidget {
  final AppinioSwiperController explorePeopleController;

  const ExplorePeopleButtonWidget({
    Key? key,
    required this.explorePeopleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MatchButtonWidget(
          onTap: () {
            explorePeopleController.swipeLeft();
          },
          iconPath: 'icon_close.png',
        ),
        MatchButtonWidget(
          onTap: () {
            explorePeopleController.swipe();
          },
          dimension: 80.0,
          iconPath: 'icon_love.png',
        ),
        MatchButtonWidget(
          onTap: () {
            explorePeopleController.swipeRight();
          },
          iconPath: 'icon_favorite.png',
        ),
      ],
    );
  }
}
