import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/update/avatar_bottom_sheet.dart';
import 'package:movies_app/UI/auth/widgets/custom-elevated-button.dart';
import 'package:movies_app/UI/auth/widgets/custom-text-form-field.dart';
import 'package:movies_app/api/api-constant.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/model/register_response.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

import '../../../app-prefrences/user_storage.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/dialog-utils.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  UserData? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedIndex = 0;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider
          .of<UserProvider>(context, listen: false);
      print('UserProvider - UPDATE ====> ${provider.hashCode}');
      var fetchedUser = Provider
          .of<UserProvider>(context, listen: false)
          .user;
      print('====> $fetchedUser');
      if (fetchedUser == null) return;
      setState(() {
        user = fetchedUser;
        nameController.text = user!.name ?? '';
        phoneController.text = user!.phone ?? "";
        selectedIndex = user!.avaterId ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

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
      body:
      // user == null
      //     ? const Center(child: CircularProgressIndicator())
      //     : SingleChildScrollView(
      //   child:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * .2,
                width: width * .5,
                child: InkWell(
                  onTap: () {
                    showAvatarBottomSheet();
                  },
                  child: Image(
                    image: AssetImage(
                        ApiConstants.avatarImagesList[selectedIndex]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              CustomTextFormField(
                controller: nameController,
                prefixIcon:
                Icon(Icons.person, color: AppColors.whiteColor),
              ),
              SizedBox(height: height * .02),
              CustomTextFormField(
                controller: phoneController,
                prefixIcon:
                Icon(Icons.phone, color: AppColors.whiteColor),
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
                      ApiManager.deleteAccount();
                      DialogUtils.showMsg(context: context, msg: 'User Deleted Succeffully',
                      posActionName: 'Ok',
                      posAction:  (){
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.loginRouteName,
                        (route) => false
                        );
                      });
                    },
                    colorSide: AppColors.transparentColor,
                    textStyle: AppStyles.regular20White,
                    text: AppLocalizations.of(context)!.deleteAccount,
                  ),
                  SizedBox(height: height * .02),
                  CustomElevatedButton(
                    onPressed: () {
                      updateData();
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

  void showAvatarBottomSheet() async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) => AvatarBottomSheet(selectedIndex: selectedIndex),
    );

    if (result != null) {
      setState(() {
        selectedIndex = result["index"];
      });
    }
  }
  void updateData() async {
    if (user == null) return;

    var updatedUser = UserData(
      id: user!.id,
      name: nameController.text,
      email: user!.email,
      phone: phoneController.text,
      avaterId: selectedIndex,
    );

    await UserStorage.saveUser(updatedUser);
    Provider.of<UserProvider>(context, listen: false).setUser(
        updatedUser);

    Navigator.pop(context);
  }
}
