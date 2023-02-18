import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/people_identity_widget.dart';
import 'package:sarang_app/src/common_widgets/profile_detail_image_widget.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_model.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class PeopleProfileScreen extends StatefulWidget {
  static const String routeName = '/people-profile';
  const PeopleProfileScreen({super.key});

  @override
  State<PeopleProfileScreen> createState() => _PeopleProfileScreenState();
}

class _PeopleProfileScreenState extends State<PeopleProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userData = ModalRoute.of(context)!.settings.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lover Profile',
          style: getWhiteTextStyle(
            fontSize: FontSizeManager.f20,
            fontWeight: FontWeightManager.semiBold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileDetailImageWidget(
              imagePath: userData.imagePath,
            ),
            const SizedBox(
              height: 30.0,
            ),
            PeopleIdentityWidget(
              fullname: userData.fullName,
              age: userData.age,
              occupation: userData.occupation,
              bio: userData.bio,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: AppMargin.m24,
                top: AppMargin.m16,
              ),
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: AppMargin.m16),
                    width: 120.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      image: DecorationImage(
                        image: AssetImage(
                          userData.listImage![index]!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                itemCount: userData.listImage?.length ?? 0,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
