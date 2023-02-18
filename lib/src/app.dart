import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_screens/image_view_screen.dart';
import 'package:sarang_app/src/features/authentication/data/data_user_account_local.dart';
import 'package:sarang_app/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_age_job_screen.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_screen.dart';
import 'package:sarang_app/src/features/authentication/presentation/sign_up_upload_photo_screen.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/explorepeople/explore_people_bloc.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/peopleloved/people_loved_bloc.dart';
import 'package:sarang_app/src/features/likes_you/presentation/explore_people_screen.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_loved_screen.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_loved_you_profile_screen.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_profile_screen.dart';
import 'package:sarang_app/src/features/user/presentation/user_profile_screen.dart';
import 'package:sarang_app/src/theme_manager/theme_data_manager.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  bool isRegister = false;

  isUserRegister() async {
    isRegister = await UserAccountRegister.getUserAccountRegister();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isUserRegister();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ExplorePeopleBloc(),
        ),
        BlocProvider(
          create: (context) => PeopleLovedBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationThemeData(),
        home: isRegister == true
            ? const ExplorePeopleScreen()
            : const SignUpScreen(),
        routes: {
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          SignUpAgeJobScreen.routeName: (context) => const SignUpAgeJobScreen(),
          SignUpUploadPhotoScreen.routeName: (context) =>
              const SignUpUploadPhotoScreen(),
          ExplorePeopleScreen.routeName: (context) =>
              const ExplorePeopleScreen(),
          PeopleLovedScreen.routeName: (context) => const PeopleLovedScreen(),
          PeopleProfileScreen.routeName: (context) =>
              const PeopleProfileScreen(),
          ImageViewScreen.routeName: (context) => const ImageViewScreen(),
          UserProfileScreen.routeName: (context) => const UserProfileScreen(),
          PeopleLovedYouProfileScreen.routeName: (context) =>
              const PeopleLovedYouProfileScreen(),
        },
      ),
    );
  }
}
