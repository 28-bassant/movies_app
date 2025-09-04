import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class GenresWidget extends StatelessWidget {
  String text;
   GenresWidget({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .01
      ),
      child: Text(text,style: AppStyles.regular16White,textAlign: TextAlign.center,),
    );
  }
}
