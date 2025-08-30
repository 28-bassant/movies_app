import 'package:flutter/material.dart';

class ScreenshotCustomWidget extends StatelessWidget {
  String image;
   ScreenshotCustomWidget({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
