import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScreenshotCustomWidget extends StatelessWidget {
  String image;
   ScreenshotCustomWidget({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      child: CachedNetworkImage(
        imageUrl: image ?? '',
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
