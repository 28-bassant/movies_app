import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api-constant.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:movies_app/app-prefrences/user_storage.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog-utils.dart';
import 'package:provider/provider.dart';
import '../../../providers/app-language-provider.dart';
import '../../../providers/user_provider.dart';
import '../widgets/custom-elevated-button.dart';
import '../widgets/custom-text-form-field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "route@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: 'Route123@',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: 'Route123@',
  );
  TextEditingController phoneController = TextEditingController(
    text: '+201141209334',
  );
  TextEditingController nameController = TextEditingController(text: 'Route');
  int avaterId = 0;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.blackBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackBgColor,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.regular16Orange,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.orangeColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(height: height * .2,
                    enlargeCenterPage: true,
                    viewportFraction: 0.33,
                  ),
                  items: ApiConstants.avatarImagesList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String path = entry.value;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          avaterId = index ;
                        });
                      },
                      child: Container(
                        width: width * .4,
                        child: Image.asset(ApiConstants.avatarImagesList[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: height * .02),
              Text(
                AppLocalizations.of(context)!.avatar,
                style: AppStyles.regular16White,
              ),
              SizedBox(height: height * .02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.name,
                      prefixIcon: ImageIcon(
                        AssetImage(AppAssets.nameIcon),
                        color: AppColors.whiteColor,
                      ),
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_name;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.email,
                      prefixIcon: Image(image: AssetImage(AppAssets.emailIcon)),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_email;
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(emailController.text);
                        if (!emailValid) {
                          return AppLocalizations.of(context)!.valid_email;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.password,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
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
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
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
                    SizedBox(height: height * .02),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context)!.phoneNumber,
                      prefixIcon: ImageIcon(
                        AssetImage(AppAssets.phoneIcon),
                        color: AppColors.whiteColor,
                      ),
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_enter_phone_number;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * .02),
                    CustomElevatedButton(
                      onPressed: () {
                        //todo : Navigate to Home Screen
                        register();

                      },
                      text: AppLocalizations.of(context)!.createAccount,
                    ),
                    SizedBox(height: height * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: AppStyles.regular14White,
                        ),
                        SizedBox(width: width * .0001),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: AppStyles.black14Orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .02),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            width: 1.5,
                            color: AppColors.orangeColor,
                          ),
                        ),
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
                                    color:
                                    languageProvider.appLanguage == 'en'
                                        ? AppColors.orangeColor
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage(AppAssets.usFlag),
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
                                    color:
                                    languageProvider.appLanguage == 'ar'
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        //todo : Show Loading
        DialogUtils.showLopading(textLoading: "Loading...", context: context);
        var response = await ApiManager.register(
          emailController.text,
          nameController.text,
          passwordController.text,
          confirmPasswordController.text,
          phoneController.text,
          avaterId,
        );
        //todo : hide Loading
        DialogUtils.hideLoading(context: context);

        if (response.message == 'User created successfully') {
          if (response.data != null) {
            await UserStorage.saveUser(response.data!);
            Provider.of<UserProvider>(context, listen: false).setUser(response.data!);

          }
          //todo:show msg
          DialogUtils.showMsg(
            context: context,
            title: "Success",
            msg: "Registered Successfully",
            posActionName: "OK",
            posAction: () {
              //todo:navigate to home
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreendRouteName, (route) => true,);
            },
          );
        } else {
          //todo : error from server
          //todo : show meg
          DialogUtils.showMsg(
            context: context,
            msg: response.message ?? '',
            posActionName: 'ok',
          );
        }
      } catch (e) {
        //todo : hide Loading
        DialogUtils.hideLoading(context: context);
        //todo : error from client
        DialogUtils.showMsg(
          context: context,
          msg: e.toString(),
          posActionName: 'ok',
        );
      }

    }
  }
}
