import 'package:flutter/material.dart';
import 'package:sarang_app/src/common_widgets/banner_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_field_widget.dart';
import 'package:sarang_app/src/features/authentication/domain/user_account_model.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_age_job_screen.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.clear();
    _nameController.dispose();
    _emailController.clear();
    _emailController.dispose();
    _passwordController.clear();
    _passwordController.dispose();
    super.dispose();
  }

  String? validationInput() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      return 'Name or Email or Password can\'t be empty';
    }

    if (_nameController.text.length < 4 ||
        _emailController.text.length < 4 ||
        _passwordController.text.length < 4) {
      return 'Too short, minimum 4 characters';
    }

    if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      return 'Email not valid';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppMargin.m50,
            horizontal: AppMargin.m24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BannerWidget(),
              CustomTextFieldWidget(
                labelName: 'Complete Name',
                hintText: 'Write your name',
                controller: _nameController,
              ),
              CustomTextFieldWidget(
                labelName: 'Email Address',
                hintText: 'Write your email address',
                controller: _emailController,
              ),
              CustomTextFieldWidget(
                isObsecure: true,
                labelName: 'Password',
                hintText: 'Write your security',
                controller: _passwordController,
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomButtonWidget(
                onTap: () {
                  final errorMessage = validationInput();

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
                      SignUpAgeJobScreen.routeName,
                      arguments: UserAccountModel(
                        fullname: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        occupation: '',
                        age: '',
                      ),
                    );
                  }
                },
                title: 'Get Started',
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextButtonWidget(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Coming Soon',
                        style: getWhiteTextStyle(),
                      ),
                      backgroundColor: ColorManager.pink,
                    ),
                  );
                },
                title: 'Sign In to My Account',
              )
            ],
          ),
        ),
      ),
    );
  }
}
