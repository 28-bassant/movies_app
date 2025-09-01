import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class ScreenshotCustomWidget extends StatelessWidget {
  String image;
   ScreenshotCustomWidget({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ClipRRect(
        child: CachedNetworkImage(
          imageUrl:image,
          placeholder: (context, url) => Center(child: CircularProgressIndicator(
            color: AppColors.orangeColor,
          )),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }
}
