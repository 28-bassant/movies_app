import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/UI/auth/login/login-screen.dart';
import 'package:movies_app/UI/auth/on_boarding/on_boarding_screen.dart';
import 'package:movies_app/UI/auth/update/update_screen.dart';
import 'package:movies_app/providers/app-language-provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'UI/auth/register/register_screen.dart';
import 'l10n/app_localizations.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),

  ));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.onBoardingRouteName,
        routes: {
          AppRoutes.onBoardingRouteName: (context) => OnboardingScreen(),
          AppRoutes.loginRouteName: (context) => LoginScreen(),
          AppRoutes.registerRouteName: (context) =>RegisterScreen(),
          AppRoutes.updateRouteName: (context) =>UpdateScreen(),
        },


      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

    );

  }
}