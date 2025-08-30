import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class ScreenshotCustomWidget extends StatelessWidget {
  String image;
   ScreenshotCustomWidget({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.network(image),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
