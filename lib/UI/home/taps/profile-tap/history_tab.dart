import 'package:flutter/cupertino.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_styles.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage(AppAssets.empty_image)),
    );
  }
}