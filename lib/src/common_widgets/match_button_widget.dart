import 'package:flutter/cupertino.dart';
import 'package:sarang_app/src/helpers/layout_helper.dart';
import 'package:sarang_app/src/theme_manager/asset_image_icon_manager.dart';

class MatchButtonWidget extends StatelessWidget {
  final String iconPath;
  final double dimension;
  final VoidCallback onTap;

  const MatchButtonWidget({
    super.key,
    required this.iconPath,
    this.dimension = 50.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              '${AssetImageIconManager.imagePath}/$iconPath',
            ),
          ),
        ),
      ),
    );
  }
}
