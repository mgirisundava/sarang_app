import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_widgets/custom_button_widget.dart';
import 'package:sarang_app/src/common_widgets/people_identity_widget.dart';
import 'package:sarang_app/src/common_widgets/profile_detail_image_widget.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_model.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/peopleloved/people_loved_bloc.dart';
import 'package:sarang_app/src/helpers/layout_helper.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class PeopleLovedYouProfileScreen extends StatefulWidget {
  static const String routeName = '/people-loved-you-profile';
  const PeopleLovedYouProfileScreen({super.key});

  @override
  State<PeopleLovedYouProfileScreen> createState() =>
      _PeopleLovedYouProfileScreenState();
}

class _PeopleLovedYouProfileScreenState
    extends State<PeopleLovedYouProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userData = ModalRoute.of(context)!.settings.arguments as UserModel;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).clearSnackBars();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
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
          actions: [
            TouchableOpacity(
              onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                context.read<PeopleLovedBloc>().add(
                      DeletePeopleLoved(user: userData),
                    );
                Navigator.pop(context, true);
              },
              child: const Icon(
                Icons.cancel_outlined,
                size: 30.0,
              ),
            ),
            const SizedBox(
              width: 15.0,
            )
          ],
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
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
                child: CustomButtonWidget(
                  onTap: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Coming soon',
                          style: getWhiteTextStyle(),
                        ),
                        backgroundColor: ColorManager.pink,
                      ),
                    );
                  },
                  title: 'Chat Now',
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
