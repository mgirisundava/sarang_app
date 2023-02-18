import 'package:sarang_app/src/features/likes_you/data/data_hobby_dummy.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_model.dart';
import 'package:sarang_app/src/theme_manager/asset_image_icon_manager.dart';

List<UserModel> dataUserDummy = [
  UserModel(
    fullName: 'Yunita',
    age: '22',
    occupation: 'Teacher',
    bio:
        'Improve economy of the world by teaching students how to manage money and invest to the greater good in these luxury.',
    imagePath: '${AssetImageIconManager.imagePath}/people_love1_image.png',
    listImage: dataHobbyDummy,
  ),
  UserModel(
    fullName: 'Rimadona',
    age: '24',
    occupation: 'Doctor',
    bio:
        'Helping people life is really fun for me and I really wanted to cure the world from all of the disease that we currently have.',
    imagePath: '${AssetImageIconManager.imagePath}/people_love2_image.png',
    listImage: dataHobbyDummy,
  ),
  UserModel(
    fullName: 'Aninda',
    age: '21',
    occupation: 'Enterpreneur',
    bio:
        'I want to have big business and create a great impact for the people, finance, health, and many good things in this world.',
    imagePath: '${AssetImageIconManager.imagePath}/people_love3_image.png',
    listImage: dataHobbyDummy,
  ),
];
