import 'package:flutter/cupertino.dart';
import 'package:movies_app/utils/app_assets.dart';

class WhishlistTab extends StatelessWidget {
  const WhishlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage(AppAssets.empty_image)),
    );
  }
}