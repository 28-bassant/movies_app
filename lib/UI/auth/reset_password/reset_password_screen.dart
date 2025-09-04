import 'package:flutter/material.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_styles.dart';
import '../widgets/custom-elevated-button.dart';
import '../widgets/custom-text-form-field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context)!.reset_password,
          style: AppStyles.regular16Yellow,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.yellowColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(child: Image.asset("assets/images/forgotPassword.png")),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.old_password,
                      controller: currentPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_password;
                        }
                        if (text.length < 6) {
                          return AppLocalizations.of(context)!.valid_password;
                        }
                        return null;
                      },
                      prefixIcon: Image(image: AssetImage(AppAssets.passIcon)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      obscureText: obscure,
                      obscuringCharacter: "*",
                    ),
                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.new_password,
                      controller: newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_confirm_password;
                        }
                        if (text.length < 6) {
                          return AppLocalizations.of(context)!.valid_password;
                        }
                        return null;
                      },
                      prefixIcon: Image(image: AssetImage(AppAssets.passIcon)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      obscureText: obscure,
                      obscuringCharacter: "*",
                    ),
                    SizedBox(height: height * .05),
                    CustomElevatedButton(
                      onPressed: () {
                        resetPassword();

                      },
                      colorSide: AppColors.transparentColor,
                      textStyle: AppStyles.regular20Black,
                      text: AppLocalizations.of(context)!.update_password,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    if (formKey.currentState?.validate() != true) return;
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      await userProvider.resetPassword(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully ")),
      );
      Navigator.pushNamed(
        context,
        AppRoutes.homeScreendRouteName,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

}
