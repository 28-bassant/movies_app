import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../api/api-manager.dart';
import '../../../app-prefrences/token-storage.dart';
import '../../../providers/app-language-provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/dialog-utils.dart';
import '../widgets/custom-elevated-button.dart';
import '../widgets/custom-text-form-field.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController =TextEditingController();

  TextEditingController passwordController =TextEditingController();

  bool obscure=true;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor:Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.04),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(image: AssetImage(AppAssets.logoIcon),height: height*.20,),
                SizedBox(height: height*.02,),
                Form( key:formKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(hintText: AppLocalizations.of(context)!.email,
                          prefixIcon: Image(image: AssetImage(AppAssets.emailIcon))
                          ,controller: emailController ,
                          kerboardType: TextInputType.emailAddress,
                          validator: (text){
                            if(text ==null || text.trim().isEmpty){
                              return AppLocalizations.of(context)!.enter_email;
                            }
                            final bool emailValid =
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(emailController.text);
                            if(!emailValid){
                              return AppLocalizations.of(context)!.valid_email;
                            }
                            return null;
                          },),

                        SizedBox(height: height*.02,),
                        CustomTextFormField(hintText:AppLocalizations.of(context)!.password,
                          controller: passwordController,
                          validator: (text){
                            if(text ==null || text.trim().isEmpty){
                              return AppLocalizations.of(context)!.enter_password;
                            }
                            if(text.length<8){
                              return AppLocalizations.of(context)!.valid_password;
                            }
                            return null;
                          },

                          prefixIcon: Image(image: AssetImage(AppAssets.passIcon)),
                          suffixIcon: IconButton(onPressed: (){
                            obscure =!obscure;
                            setState(() {

                            });
                          }
                              , icon:Icon(obscure? Icons.visibility_off:Icons.visibility,color:AppColors.whiteColor,) ),
                          obscureText:obscure,obscuringCharacter:"*" ,
                        )
                        ,Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(onPressed: (){}, child:Text(AppLocalizations.of(context)!.forgetPasswordQuestion
                              ,style: AppStyles.regular16Orange.copyWith(
                                fontSize: 14,

                              ),))
                          ],),
                        SizedBox(height: height*.02,),

                        CustomElevatedButton(onPressed:(){
                          login();
                        },
                            text:AppLocalizations.of(context)!.login)
                        , SizedBox(height: height*.02,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.no_account,
                                  style:AppStyles.regular14White)
                              ,TextButton(onPressed: (){
                                //todo : Navigate to Register Screen
                                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.registerRouteName, (route) => true,);

                              },
                                  child: Text(AppLocalizations.of(context)!.create_one,style:AppStyles.black14Orange))
                            ])
                        , SizedBox(height: height*.01,)
                        ,Row(children: [
                          Expanded(child: Divider(
                            indent: width*.05,
                            endIndent:  width*.04,
                            thickness: 2,
                            color: AppColors.orangeColor,
                          )),
                          Text(AppLocalizations.of(context)!.or,style: AppStyles.regular16Orange,),
                          Expanded(child: Divider(thickness: 2,
                            indent: width*.04,
                            endIndent:  width*.06,
                            color: AppColors.orangeColor))
                        ],),
                        SizedBox(height: height*.02,),
                        CustomElevatedButton(onPressed:(){
                          loginWithGoogle(context);
                        },
                            text:AppLocalizations.of(context)!.loginWithGoogle,
                            textStyle: AppStyles.regular16Black,icon: true,iconName: AppAssets.googleIcon)

                        ,SizedBox(height: height*.04,)
                        , Align(alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(width: 1.5,color: AppColors.orangeColor)
                            ),
                            child: Row(mainAxisSize: MainAxisSize.min,
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
                                        ?
                                        AppColors.orangeColor
                                        : Colors.transparent
                                        ,width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image(image: AssetImage(AppAssets.usFlag),fit: BoxFit.cover,),
                                    ),
                                  ),
                                ),SizedBox(width: width*.03,),
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
                                        ?
                                        AppColors.orangeColor
                                        :Colors.transparent
                                        , width: 3,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image(image: AssetImage(AppAssets.egyptFlag),fit: BoxFit.cover,),
                                    ),
                                  ),
                                ),

                              ],),),
                        )
                      ],)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login() async {
    if (formKey.currentState?.validate() == true) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      try {
        //todo:show loading
        DialogUtils.showLopading(
            textLoading: "Logging in...", context: context);

        final response = await ApiManager.login(email, password);
        //todo:hide loading
        DialogUtils.hideLoading(context: context);

        if (response.message == "Success Login") {
            if (response.token != null) {
              await TokenStorage.saveToken(response.token!);
            }
            //todo:success
          //todo:show msg
          DialogUtils.showMsg(
              context: context,
              title: "Success",
              msg: "Login Successful",
              posActionName: "OK",
              posAction: () {
                //todo:navigate to home
              }
          );
        } else {
          //todo:server error
          //todo:show msg
          DialogUtils.showMsg(
            context: context,
            title: "Login Failed",
            msg: response.message,
            posActionName: "Ok",
          );
        }
      }
      //todo:client error
        on SocketException {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMsg(
            context: context,
            title: "No Internet",
            msg: "Please check your internet connection and try again.",
            posActionName: "Retry",
          );
        } catch (e) {
        //todo:hide loading
        DialogUtils.hideLoading(context: context);
        //todo:show msg
        DialogUtils.showMsg(
          context: context,
          title: "Login Failed ",
          msg: e.toString().replaceFirst("Exception:", "").trim(),
          posActionName: "Ok",
        );
      }
    }

  }
  Future loginWithGoogle(BuildContext context) async {
    try {
      final account = await googleSignIn.signIn();
      if (account != null) {
        DialogUtils.showMsg(
          context: context,
          title: "Success",
          msg: "Welcome, ${account.displayName}",
          posActionName: "OK",
          posAction: () {
            // TODO: Navigate to home

          },
        );
        debugPrint("User Email: ${account.email}");
        debugPrint("User Name: ${account.displayName}");
        debugPrint("User ID: ${account.id}");
      } else {
        DialogUtils.showMsg(
          context: context,
          title: "Cancelled",
          msg: "Google login was cancelled",
          posActionName: "OK",
        );
      }
    } catch (e) {
      DialogUtils.showMsg(
        context: context,
        title: "Error",
        msg: "Google login failed: $e",
        posActionName: "OK",
      );
    }
  }
}
