import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/forget_password/forget_password_screen.dart';
import 'package:movies_app/UI/auth/login/login-screen.dart';
import 'package:movies_app/providers/app-language-provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';



void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LanguageProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.forgetPasswordRouteName,
      routes: {
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),

      },
      locale: Locale(languageProvider.appLanguage),
       localizationsDelegates: AppLocalizations.localizationsDelegates,
       supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
