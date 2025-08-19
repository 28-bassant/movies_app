import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/widgets/custom-elevated-button.dart';
import 'package:movies_app/UI/auth/widgets/custom-text-form-field.dart';
import 'package:movies_app/utils/app_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.orangeColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
          style: TextStyle(
            color: AppColors.orangeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  child: Image.asset("assets/images/forgotPassword.png"),
                ),
                 SizedBox(height:height*.02),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppLocalizations.of(context)!.email,
                  hintStyle: AppStyles.regular20White,
                  prefixIcon: Image(image: AssetImage(AppAssets.emailIcon)),
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enter_email;
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text);
                    if (!emailValid) {
                      return AppLocalizations.of(context)!.valid_email;
                    }
                    return null;
                  },
                ),
                SizedBox(height:height*.02),

                CustomElevatedButton(
                  text: AppLocalizations.of(context)!.verifyEmail,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      return Navigator.pop(context);
                    } else {
                      (AppLocalizations.of(context)!.enter_email);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
