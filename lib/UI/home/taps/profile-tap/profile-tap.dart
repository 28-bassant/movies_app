import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/widgets/custom-elevated-button.dart';
import 'package:movies_app/UI/home/taps/profile-tap/whishlist_tab.dart';
import 'package:movies_app/api/api-constant.dart';
import 'package:movies_app/app-prefrences/user_storage.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/model/register_response.dart';
import 'package:movies_app/providers/app-language-provider.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../../auth/update/update_screen.dart';
import 'history_tab.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTap> {
  bool isWishList = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);

    int avatarIndex = user?.avaterId ?? 0;

    return Scaffold(
      backgroundColor: AppColors.darkGreyColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * .06,
              left: width * .04,
              right: width * .04,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      child: Image(
                        image: AssetImage(
                          ApiConstants.avatarImagesList[avatarIndex],
                        ),
                        width: width * .35,
                        height: height * .15,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Text('12', style: AppStyles.bold36White),
                        Text(
                          AppLocalizations.of(context)!.wishList,
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('10', style: AppStyles.bold36White),
                        Text(
                          AppLocalizations.of(context)!.history,
                          style: AppStyles.bold24White,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
                Container(
                  alignment: languageProvider.appLanguage == 'en'
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: Text(
                    user?.name ?? 'Guest',
                    style: AppStyles.bold20White,
                  ),
                ),
                SizedBox(height: height * .02),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => UpdateScreen()),
                          );
                          setState(() {

                          });

                        },

                        text: AppLocalizations.of(context)!.edit_profile,
                      ),
                    ),
                    SizedBox(width: width * .02),
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () async{
                          //todo: Navigate to Login
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.loginRouteName,
                                (route) => false,
                          );

                        },
                        text: AppLocalizations.of(context)!.exit,
                        backgroundColorButton: AppColors.redColor,
                        colorSide: AppColors.transparentColor,
                        textStyle: AppStyles.regular20White,
                        iconName: AppAssets.exit_icon,
                        isSuffixIcon: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        isWishList = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .08,
                          vertical: height * .02,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: isWishList == true ? 3 : 0,
                              color:
                              isWishList == true
                                  ? AppColors.orangeColor
                                  : AppColors.transparentColor,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Image(image: AssetImage(AppAssets.wishList_icon)),
                            SizedBox(height: height * .01),
                            Text(
                              AppLocalizations.of(context)!.wishList,
                              style: AppStyles.regular20White,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        isWishList = false;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .08,
                          vertical: height * .01,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: isWishList == false ? 3 : 0,
                              color:
                              isWishList == false
                                  ? AppColors.orangeColor
                                  : AppColors.transparentColor,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Image(image: AssetImage(AppAssets.history_icon)),
                            SizedBox(height: height * .01),
                            Text(
                              AppLocalizations.of(context)!.history,
                              style: AppStyles.regular20White,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.blackBgColor,
              child: isWishList ? WhishlistTab() : HistoryTab(),
            ),
          ),
        ],
      ),
    );

  }
}



