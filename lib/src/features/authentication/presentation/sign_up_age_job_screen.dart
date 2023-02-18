import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/banner_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_field_widget.dart';
import 'package:sarang_app/src/features/authentication/domain/user_account_model.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_upload_photo_screen.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';

import '../../../theme_manager/value_manager.dart';

class SignUpAgeJobScreen extends StatefulWidget {
  static const String routeName = '/sign-up-age-job';
  const SignUpAgeJobScreen({super.key});

  @override
  State<SignUpAgeJobScreen> createState() => _SignUpAgeJobScreenState();
}

class _SignUpAgeJobScreenState extends State<SignUpAgeJobScreen> {
  final _jobController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _jobController.clear();
    _jobController.dispose();
    _ageController.clear();
    _ageController.dispose();
    super.dispose();
  }

  String? validationInput() {
    if (_jobController.text.isEmpty || _ageController.text.isEmpty) {
      return 'Occupation or Age can\'t be empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var registerData =
        ModalRoute.of(context)!.settings.arguments as UserAccountModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m50,
            horizontal: AppMargin.m24,
          ),
          child: Column(
            children: [
              const BannerWidget(),
              CustomTextFieldWidget(
                labelName: 'Occupation',
                hintText: 'Write your occupation',
                controller: _jobController,
              ),
              CustomTextFieldWidget(
                labelName: 'Age',
                hintText: 'Write your age',
                controller: _ageController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 117.0,
              ),
              CustomButtonWidget(
                onTap: () {
                  String? errorMessage = validationInput();

                  if (errorMessage != null) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          errorMessage,
                          style: getWhiteTextStyle(),
                        ),
                        backgroundColor: ColorManager.pink,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    Navigator.pushNamed(
                      context,
                      SignUpUploadPhotoScreen.routeName,
                      arguments: UserAccountModel(
                        fullname: registerData.fullname,
                        email: registerData.email,
                        password: registerData.password,
                        occupation: _jobController.text,
                        age: _ageController.text,
                      ),
                    );
                  }
                },
                title: 'Continue Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
