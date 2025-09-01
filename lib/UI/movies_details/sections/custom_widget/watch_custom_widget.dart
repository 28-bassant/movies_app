import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class WatchCustomWidget extends StatelessWidget {
  String image;
  var text;
   WatchCustomWidget({super.key,required this.image,required this.text});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .01
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(16)

      ),
      child: Row(
        children: [
          Image(image: AssetImage(image)),
          SizedBox(width: width * .02,),
          Text('$text',style: AppStyles.bold24White,)
        ],
      ),
    );
  }
}
