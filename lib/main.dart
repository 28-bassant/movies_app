import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/forget_password/forget_password_screen.dart';
import 'package:movies_app/UI/auth/login/login-screen.dart';
import 'package:movies_app/UI/auth/update/update_screen.dart';
import 'package:movies_app/UI/movies_details/movies_details_screen.dart';
import 'package:movies_app/providers/app-language-provider.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'UI/auth/register/register_screen.dart';
import 'UI/auth/reset_password/reset_password_screen.dart';
import 'UI/home/home_screen/home_screen.dart';
import 'UI/on_boarding/on_boarding_screen.dart';
import 'l10n/app_localizations.dart';
import 'package:movies_app/UI/home/taps/prowse-tap/browse_tab.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.onBoardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
        AppRoutes.updateRouteName: (context) => UpdateScreen(),
        AppRoutes.homeScreendRouteName: (context) => HomeScreen(),
        AppRoutes.resetPasswordRouteName: (context) => ResetPasswordScreen(),
        AppRoutes.movieDetailsScreenRouteName: (context) {
          final movieId = ModalRoute.of(context)!.settings.arguments as int;
          return MoviesDetailsScreen(movieId: movieId);
        },


      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
