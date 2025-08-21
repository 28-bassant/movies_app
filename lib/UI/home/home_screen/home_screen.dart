import 'package:flutter/material.dart';
import 'package:movies_app/UI/home/taps/prowse-tap/prowse-tap.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../taps/home-tap/home-tap.dart';
import '../taps/profile-tap/profile-tap.dart';
import '../taps/search-tap/search-tap.dart';

class HomeScreen extends StatefulWidget{

  HomeScreen();
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> taps=[
    HomeTap(),SearchTap(),ProwseTap(),ProfileTap()
  ];
   int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      bottomNavigationBar:
      Container(
        margin:EdgeInsets.symmetric(
          horizontal: width * .02,
          vertical: height * .027,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkGreyColor,
        ),
        height: height*.066,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavIcon(selectedIconName: AppAssets.selectedHomeIcon, unSelectedIconName:AppAssets.homeIcon, index:0),
            buildNavIcon(selectedIconName: AppAssets.selectedSearchIcon, unSelectedIconName:AppAssets.searchIcon, index:1),
            buildNavIcon(selectedIconName: AppAssets.selectedProwseIcon,unSelectedIconName: AppAssets.prowseIcon,index: 2),
            buildNavIcon(selectedIconName: AppAssets.selectedProfileIcon,unSelectedIconName: AppAssets.profileIcon,index: 3),
          ],
        ),
      ),
      body: taps[selectedIndex],
    );
  }
  Widget buildNavIcon({required String selectedIconName ,required String unSelectedIconName ,required int index,}) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            AssetImage(isSelected ?selectedIconName : unSelectedIconName),
            size: 24,
            color: isSelected ? AppColors.orangeColor : AppColors.whiteColor,
          ),

        ],
      ),
    );
  }
}