import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/login/cubit/login-view-model.dart';

import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../providers/app-language-provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/dialog-utils.dart';
import '../widgets/custom-elevated-button.dart';
import '../widgets/custom-text-form-field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login-state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController =
  TextEditingController(text: 'route@gmail.com');
  TextEditingController passwordController =
  TextEditingController(text: 'Route123@');
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);

    return BlocProvider(
        create: (_) => LoginViewModel(),
        child: BlocConsumer<LoginViewModel, LoginState>(
        listener: (context, state) {
      //todo: Loading
          if (state is LoginLoading) {
            DialogUtils.showLopading(
              textLoading: "Logging in...",
              context: context,
            );
          } else {
            //todo: hide Loading
            DialogUtils.hideLoading(context: context);
          }
          //todo: success
          if (state is LoginSuccess) {
            context.read<UserProvider>().setUser(state.user);
            DialogUtils.showMsg(
              context: context,
              title: "Success",
              msg: state.message,
              posActionName: "OK",
                // TODO: Navigate to home
              posAction: (){
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.homeScreendRouteName,
                      (route) => false,
                );
              }
            );

          } else if (state is LoginFailure) {
            DialogUtils.showMsg(
              context: context,
              title: "Login Failed",
              msg: state.error,
              posActionName: "OK",
            );
          }
      //todo: Google Login
      if (state is GoogleLoginSuccess) {
        DialogUtils.showMsg(
          context: context,
          title: "Success",
          msg: "Welcome, ${state.name}",
          posActionName: "OK",
            // TODO: Navigate to home
            posAction: (){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreendRouteName,
                    (route) => false,
              );
            }
        );
      } else if (state is GoogleLoginCancelled) {
        DialogUtils.showMsg(
          context: context,
          title: "Cancelled",
          msg: "Google login was cancelled",
          posActionName: "OK",
        );
      } else if (state is GoogleLoginFailure) {
        DialogUtils.showMsg(
          context: context,
          title: "Error",
          msg: state.error,
          posActionName: "OK",
        );
      }
    },
    builder: (context, state) {
    final cubit = context.read<LoginViewModel>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage(AppAssets.logoIcon),
                  height: height * .20,
                ),
                SizedBox(height: height * .02),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        hintText: AppLocalizations.of(context)!.email,
                        prefixIcon:
                        Image(image: AssetImage(AppAssets.emailIcon)),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_email;
                          }
                          final emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^*`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .valid_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * .02),
                      CustomTextFormField(
                        hintText:
                        AppLocalizations.of(context)!.password,
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_password;
                          }
                          if (text.length < 8) {
                            return AppLocalizations.of(context)!
                                .valid_password;
                          }
                          return null;
                        },
                        prefixIcon:
                        Image(image: AssetImage(AppAssets.passIcon)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: Icon(
                            obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        obscureText: obscure,
                        obscuringCharacter: "*",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.forgetPasswordRouteName,
                                      (route) => true,
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .forgetPasswordQuestion,
                                style: AppStyles.regular16Orange
                                    .copyWith(fontSize: 14),
                              ))
                        ],
                      ),
                      SizedBox(height: height * .02),
                      CustomElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            cubit.login(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        text: AppLocalizations.of(context)!.login,
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.no_account,
                            style: AppStyles.regular14White,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.registerRouteName,
                                      (route) => true,
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context)!.create_one,
                                style: AppStyles.black14Orange,
                              ))
                        ],
                      ),
                      SizedBox(height: height * .01),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                indent: width * .05,
                                endIndent: width * .04,
                                thickness: 2,
                                color: AppColors.orangeColor,
                              )),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: AppStyles.regular16Orange,
                          ),
                          Expanded(
                              child: Divider(
                                thickness: 2,
                                indent: width * .04,
                                endIndent: width * .06,
                                color: AppColors.orangeColor,
                              ))
                        ],
                      ),
                      SizedBox(height: height * .02),
                      CustomElevatedButton(
                          onPressed: () {
                            context.read<LoginViewModel>().loginWithGoogle();
                          },
                          text: AppLocalizations.of(context)!
                              .loginWithGoogle,
                          textStyle: AppStyles.regular16Black,
                          icon: true,
                          iconName: AppAssets.googleIcon),
                      SizedBox(height: height * .04),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  width: 1.5,
                                  color: AppColors.orangeColor)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  languageProvider.changeLanguage('en');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: languageProvider
                                          .appLanguage ==
                                          'en'
                                          ? AppColors.orangeColor
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image(
                                      image:
                                      AssetImage(AppAssets.usFlag),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * .03),
                              GestureDetector(
                                onTap: () {
                                  languageProvider.changeLanguage('ar');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: languageProvider
                                          .appLanguage ==
                                          'ar'
                                          ? AppColors.orangeColor
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image(
                                      image: AssetImage(AppAssets.egyptFlag),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    },
        ),
    );
  }
}



