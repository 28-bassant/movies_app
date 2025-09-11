import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../../../../utils/app_colors.dart';

class MovieWidget extends StatelessWidget {
  final String image;
  final num rating;

  const MovieWidget({
    super.key,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(color: AppColors.orangeColor),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),

        Positioned(
          top: 6,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$rating',
                  style: AppStyles.regular16White,
                ),
                const SizedBox(width: 4),
                Image.asset(
                  AppAssets.rateIcon,
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
