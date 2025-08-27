import 'package:flutter/material.dart';
import 'package:movies_app/api/api-constant.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';

import '../../../utils/app_assets.dart';

class AvatarBottomSheet extends StatefulWidget {
  int selectedIndex;
  AvatarBottomSheet({super.key,required this.selectedIndex});

  @override
  State<AvatarBottomSheet> createState() => _AvatarBottomSheetState();
}

class _AvatarBottomSheetState extends State<AvatarBottomSheet> {
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = widget.selectedIndex;
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .5,
      color: AppColors.darkGreyColor,
      padding: EdgeInsets.symmetric(
        horizontal: width * .02,
        vertical: height * .02
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          crossAxisSpacing: width * .02,
          mainAxisSpacing: height * .01
        ),
        itemCount: ApiConstants.avatarImagesList.length,

        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
              Navigator.pop(context, {
                "image": ApiConstants.avatarImagesList[index],
                "index": index,
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color:currentIndex == index? AppColors.orangeColor.withAlpha(56) : AppColors.transparentColor,
                  border: Border.all(
                      color: AppColors.orangeColor
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Image(image: AssetImage(ApiConstants.avatarImagesList[index])),
            ),
          );
        },
      ),
    );
  }
}
