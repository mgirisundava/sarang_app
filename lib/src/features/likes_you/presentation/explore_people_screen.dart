import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_widgets/explore_people_app_bar_widget.dart';
import 'package:sarang_app/src/common_widgets/explore_people_button_widget.dart';
import 'package:sarang_app/src/common_widgets/match_card_widget.dart';
import 'package:sarang_app/src/features/authentication/data/data_user_account_local.dart';
import 'package:sarang_app/src/features/authentication/domain/user_account_model.dart';
import 'package:sarang_app/src/features/likes_you/data/data_hobby_dummy.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/explorepeople/explore_people_bloc.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/peopleloved/people_loved_bloc.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class ExplorePeopleScreen extends StatefulWidget {
  static const String routeName = '/explore-people';
  const ExplorePeopleScreen({super.key});

  @override
  State<ExplorePeopleScreen> createState() => _ExplorePeopleScreenState();
}

class _ExplorePeopleScreenState extends State<ExplorePeopleScreen> {
  UserAccountModel? userAccount;
  AppinioSwiperController explorePeopleController = AppinioSwiperController();

  _getUserAccountData() async {
    final data = await DataUserAccountLocal.getDataUserAccountFromStorage();
    final result = UserAccountModel.fromMap(data);
    setState(() {
      userAccount = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserAccountData();
    context.read<ExplorePeopleBloc>().add(OnExplorePeopleEventCalled());
  }

  // @override
  // void dispose() {
  //   explorePeopleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m50,
          horizontal: AppMargin.m24,
        ),
        child: Column(
          children: [
            ExplorePeopleAppBarWidget(
              userAccount: userAccount,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<ExplorePeopleBloc, ExplorePeopleState>(
                      builder: (context, explorePeople) {
                        if (explorePeople is ExplorePeopleLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.pink,
                            ),
                          );
                        } else if (explorePeople is ExplorePeopleSuccess) {
                          final users = explorePeople.result;
                          List<Widget> cards = [];
                          for (var user in users) {
                            cards.add(
                              MatchCardWidget(
                                userData: user,
                              ),
                            );
                          }
                          return Column(
                            children: [
                              TextAnimator(
                                'Tap card to see detail',
                                style: getBlack30TextStyle(
                                  fontSize: FontSizeManager.f14,
                                  fontWeight: FontWeightManager.light,
                                ),
                                incomingEffect: WidgetTransitionEffects
                                    .incomingSlideInFromLeft(
                                  curve: Curves.decelerate,
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                ),
                                atRestEffect: WidgetRestingEffects.size(),
                                outgoingEffect: WidgetTransitionEffects
                                    .outgoingSlideOutToRight(),
                                // spaceDelay: Duration(milliseconds: 100),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Expanded(
                                child: AppinioSwiper(
                                  padding: const EdgeInsets.all(0.0),
                                  controller: explorePeopleController,
                                  direction: AppinioSwiperDirection.top,
                                  cards: cards,
                                  onSwipe: (
                                    int index,
                                    AppinioSwiperDirection direction,
                                  ) {
                                    if (direction ==
                                        AppinioSwiperDirection.top) {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Yeay, you matched with ${users[index].fullName}!',
                                            style: getWhiteTextStyle(),
                                          ),
                                          backgroundColor: ColorManager.pink,
                                        ),
                                      );
                                    }

                                    if (direction !=
                                            AppinioSwiperDirection.left &&
                                        direction !=
                                            AppinioSwiperDirection.right &&
                                        direction !=
                                            AppinioSwiperDirection.bottom) {
                                      users[index].listImage = dataHobbyDummy;
                                      context.read<PeopleLovedBloc>().add(
                                            AddPeopleLoved(
                                              user: users[index],
                                            ),
                                          );
                                    }
                                  },
                                  onEnd: () {
                                    context.read<ExplorePeopleBloc>().add(
                                          OnExplorePeopleEventCalled(),
                                        );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              'Error, please refresh the app',
                              style: getWhiteTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ExplorePeopleButtonWidget(
                    explorePeopleController: explorePeopleController,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
