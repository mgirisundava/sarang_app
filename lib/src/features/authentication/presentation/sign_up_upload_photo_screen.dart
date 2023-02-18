import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_screens/image_view_screen.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/custom_text_button_widget.dart';
import 'package:sarang_app/src/common_widgets/logo_and_tagline_widget.dart';
import 'package:sarang_app/src/features/authentication/domain/user_account_model.dart';
import 'package:sarang_app/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:sarang_app/src/features/likes_you/presentation/explore_people_screen.dart';
import 'package:sarang_app/src/helpers/layout_helper.dart';
import 'package:sarang_app/src/theme_manager/asset_image_icon_manager.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';
import 'package:sarang_app/src/utils/image_picker_util.dart';

class SignUpUploadPhotoScreen extends StatefulWidget {
  static const String routeName = '/sign-up-upload-photo-screen';
  const SignUpUploadPhotoScreen({super.key});

  @override
  State<SignUpUploadPhotoScreen> createState() =>
      _SignUpUploadPhotoScreenState();
}

class _SignUpUploadPhotoScreenState extends State<SignUpUploadPhotoScreen> {
  File? image;
  final TextEditingController _bioController = TextEditingController();

  String? validationInput() {
    if (image == null) {
      return 'Image can\'t be empty';
    }

    if (_bioController.text.isNotEmpty) {
      if (_bioController.text.length < 8) {
        return 'Too short, minimum 8 characters';
      }
    }

    return null;
  }

  void _getImageProfile(GetImageFrom source) async {
    final result = await ImagePickerUtil.getImage(source);
    if (result != null) {
      setState(() {
        image = File(result.path);
      });
    } else {
      null;
    }
  }

  @override
  void dispose() {
    _bioController.clear();
    _bioController.dispose();
    super.dispose();
  }

  void _showDialog() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) => Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 17),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 20,
                  ),
                ),
              ),
              Text(
                'Pick Image',
                style: getBlackTextStyle(
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: CustomButtonWidget(
                  onTap: () {
                    _getImageProfile(GetImageFrom.camera);
                    Navigator.pop(context);
                  },
                  title: 'Camera',
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '- or -',
                style: getBlackTextStyle(
                  fontSize: FontSizeManager.f14,
                  fontWeight: FontWeightManager.semiBold,
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                child: CustomButtonWidget(
                  onTap: () {
                    _getImageProfile(GetImageFrom.gallery);
                    Navigator.pop(context);
                  },
                  title: 'Gallery',
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var registerData =
        ModalRoute.of(context)!.settings.arguments as UserAccountModel;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, register) {
        if (register is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            ExplorePeopleScreen.routeName,
            (route) => false,
          );
        } else if (register is AuthError) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Register failed, please try again',
                style: getWhiteTextStyle(),
              ),
              backgroundColor: ColorManager.pink,
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: AppMargin.m50,
              horizontal: AppMargin.m24,
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoAndTaglineWidget(),
                const SizedBox(
                  height: 50.0,
                ),
                buildUploadPhotoWidget(),
                const SizedBox(
                  height: 53.0,
                ),
                Text(
                  registerData.fullname,
                  style: getWhiteTextStyle(
                    fontSize: FontSizeManager.f22,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  '${registerData.age}, ${registerData.occupation}',
                  style: getBlack60TextStyle(),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _bioController,
                  maxLines: 5,
                  obscureText: false,
                  style: getWhiteTextStyle(),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p15,
                      horizontal: AppPadding.p30,
                    ),
                    filled: true,
                    fillColor: ColorManager.secondary,
                    hintText: 'Describe yourself... (Optional)',
                    hintStyle: getBlack30TextStyle(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 130.0,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, register) {
                    if (register is AuthLoading) {
                      return SizedBox(
                        width: double.infinity,
                        height: 55.0,
                        child: Center(
                          child: LinearProgressIndicator(
                            minHeight: 5.0,
                            color: ColorManager.pink,
                            backgroundColor: ColorManager.primary,
                          ),
                        ),
                      );
                    }
                    return CustomButtonWidget(
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
                          registerData.image = image?.path;
                          if (_bioController.text.isNotEmpty) {
                            registerData.bio = _bioController.text;
                          }
                          context.read<AuthBloc>().add(
                                RegisterAuthEvent(
                                  userAccount: registerData,
                                  isRegister: true,
                                ),
                              );
                        }
                      },
                      title: 'Update My Profile',
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextButtonWidget(
                  onPressed: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    context.read<AuthBloc>().add(
                          RegisterAuthEvent(
                            userAccount: registerData,
                            isRegister: true,
                          ),
                        );
                  },
                  title: 'Skip for Now',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUploadPhotoWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        TouchableOpacity(
          onTap: () {
            image != null
                ? Navigator.pushNamed(
                    context,
                    ImageViewScreen.routeName,
                    arguments: ImageViewArgs(
                      fileImage: image,
                    ),
                  )
                : null;
          },
          child: Container(
            width: 180.0,
            height: 180.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorManager.secondary,
                width: 8.0,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: image != null
                  ? Image(
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                    )
                  : const Image(
                      image: AssetImage(
                        '${AssetImageIconManager.imagePath}/profile_icon.png',
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: -25.0,
          child: TouchableOpacity(
            onTap: () {
              setState(() {
                _showDialog();
              });
            },
            child: const SizedBox(
              width: 50.0,
              height: 50.0,
              child: Image(
                image: AssetImage(
                  '${AssetImageIconManager.imagePath}/icon_add_color.png',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
