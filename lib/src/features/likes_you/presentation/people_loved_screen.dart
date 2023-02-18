import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sarang_app/src/common_widgets/people_loved_card_widget.dart';
import 'package:sarang_app/src/features/likes_you/presentation/bloc/peopleloved/people_loved_bloc.dart';
import 'package:sarang_app/src/features/likes_you/presentation/people_loved_you_profile_screen.dart';
import 'package:sarang_app/src/helpers/layout_helper.dart';
import 'package:sarang_app/src/theme_manager/color_manager.dart';
import 'package:sarang_app/src/theme_manager/font_manager.dart';
import 'package:sarang_app/src/theme_manager/style_manager.dart';
import 'package:sarang_app/src/theme_manager/value_manager.dart';

class PeopleLovedScreen extends StatefulWidget {
  static const String routeName = '/people-loved';
  const PeopleLovedScreen({super.key});

  @override
  State<PeopleLovedScreen> createState() => _PeopleLovedScreenState();
}

class _PeopleLovedScreenState extends State<PeopleLovedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PeopleLovedBloc>().add(OnPeopleLovedCalledEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'People You Loved',
          style: getWhiteTextStyle(
            fontSize: FontSizeManager.f20,
            fontWeight: FontWeightManager.semiBold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BlocBuilder<PeopleLovedBloc, PeopleLovedState>(
        builder: (context, peopleMatch) {
          if (peopleMatch is PeopleLovedLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.pink,
              ),
            );
          } else if (peopleMatch is PeopleLovedSuccess) {
            final peoples = peopleMatch.userMatch;

            return (peoples.isEmpty || peoples == [])
                ? Center(
                    child: Text(
                      'Empty',
                      style: getWhiteTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                      top: AppPadding.p50,
                      bottom: AppPadding.p50,
                    ),
                    itemBuilder: (context, index) {
                      return TouchableOpacity(
                        onTap: () async {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          var res = await Navigator.pushNamed(
                            context,
                            PeopleLovedYouProfileScreen.routeName,
                            arguments: peoples[index],
                          );
                          if (res == true) {
                            // ignore: use_build_context_synchronously
                            context
                                .read<PeopleLovedBloc>()
                                .add(OnPeopleLovedCalledEvent());
                          }
                        },
                        child: PeopleLovedCardWidget(
                          fullName: peoples[index].fullName,
                          age: peoples[index].age,
                          occupation: peoples[index].occupation,
                          imagePath: peoples[index].imagePath,
                          bio: peoples[index].bio,
                        ),
                      );
                    },
                    itemCount: peoples.length,
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
    );
  }
}
