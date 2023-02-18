import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_button_widget.dart';
import 'package:sarang_app/src/common_widgets/people_identity_widget.dart';
import 'package:sarang_app/src/common_widgets/profile_detail_image_widget.dart';
import 'package:sarang_app/src/features/authentication/data/data_user_account_local.dart';
import 'package:sarang_app/src/features/authentication/domain/user_account_model.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_screen.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';

class UserProfileScreen extends StatefulWidget {
  static const String routeName = '/user-profile';
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userAccount =
        ModalRoute.of(context)!.settings.arguments as UserAccountModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: getWhiteTextStyle(
            fontSize: FontSizeManager.f20,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileDetailImageWidget(
                fileImage:
                    userAccount.image != null ? File(userAccount.image!) : null,
              ),
              const SizedBox(
                height: 30.0,
              ),
              PeopleIdentityWidget(
                fullname: userAccount.fullname,
                age: userAccount.age,
                occupation: userAccount.occupation,
                bio: userAccount.bio,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomButtonWidget(
                      onTap: () {
                        UserAccountRegister.userAcountLogout();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          SignUpScreen.routeName,
                          (route) => false,
                        );
                      },
                      title: 'Log Out',
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextButtonWidget(
                    onPressed: () {
                      DataUserAccountLocal.deleteDataUserAccountFromStorage();
                      UserAccountRegister.userAcountLogout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        SignUpScreen.routeName,
                        (route) => false,
                      );
                    },
                    title: 'Delete Account',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
