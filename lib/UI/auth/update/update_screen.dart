import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/update/avatar_bottom_sheet.dart';
import 'package:movies_app/UI/auth/widgets/custom-elevated-button.dart';
import 'package:movies_app/UI/auth/widgets/custom-text-form-field.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(
      text: 'John Safwat',
    );
    TextEditingController phoneController = TextEditingController(
      text: '0123456789',
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackBgColor,
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.regular16Orange,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.orangeColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Column(
            children: [
              Container(
                height: height * .2,
                width: width * .5,
                child: InkWell(
                  onTap: () {
                    showAvatarBottomSheet();
                    setState(() {});
                  },
                  child: Image(
                    image:
                        selectedImage != null
                            ? AssetImage(selectedImage!)
                            : AssetImage(AppAssets.updateAvatar8),
                   fit: BoxFit.fill,
                  ),
                ),
              ),

              SizedBox(height: height * .02),
              CustomTextFormField(
                controller: nameController,
                prefixIcon: Icon(Icons.person, color: AppColors.whiteColor),
              ),
              SizedBox(height: height * .02),
              CustomTextFormField(
                controller: phoneController,
                prefixIcon: Icon(Icons.phone, color: AppColors.whiteColor),
              ),
              SizedBox(height: height * .04),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.of(context)!.reset_password,
                  style: AppStyles.regular20White,
                ),
              ),
              SizedBox(height: height * .25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    backgroundColorButton: AppColors.redColor,
                    onPressed: () {
                      //todo : Delete Account
                    },
                    colorSide: AppColors.transparentColor,
                    textStyle: AppStyles.regular20White,
                    text: AppLocalizations.of(context)!.deleteAccount,
                  ),
                  SizedBox(height: height * .02),
                  CustomElevatedButton(
                    onPressed: () {
                      //todo : Update Account
                    },
                    colorSide: AppColors.transparentColor,
                    textStyle: AppStyles.regular20Black,
                    text: AppLocalizations.of(context)!.updateData,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  int selectedIndex = 7;
  String? selectedImage;
  void showAvatarBottomSheet() async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) => AvatarBottomSheet(selectedIndex: selectedIndex),
    );
    if (result != null) {
      setState(() {
        selectedImage = result["image"];
        selectedIndex = result["index"];
      });
    }
  }
}
