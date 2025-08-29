import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
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

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              SizedBox(
                child: Image.asset("assets/images/forgotPassword.png"),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.new_password,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!
                              .please_enter_password;
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
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!
                              .please_confirm_password;
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
                        Navigator.pushNamed(
                            context, AppRoutes.homeScreendRouteName);
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
}
