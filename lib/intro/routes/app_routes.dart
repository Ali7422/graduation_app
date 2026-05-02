import 'package:flutter/material.dart';
import 'package:movies/features/auth_feature/auth/forget_password/forget_password_screen.dart';
import 'package:movies/features/auth_feature/auth/login/login_screen.dart';
import 'package:movies/features/auth_feature/auth/register/resgister_screen.dart';
import 'package:movies/features/home_feature/presentation/browse_tab/browes_tab.dart';
import 'package:movies/features/home_feature/presentation/home_tab/home_tab.dart';

import 'package:movies/intro/onpoarding_screens/export_app.dart';

import 'package:movies/intro/splach_screen/splash_screen.dart';
import 'package:movies/nav_bar.dart';

class AppRoutes {
  static const String splash = SplashScreen.routeName;
    static const String export = ExportApp.routeName;
  static const String login = LoginScreen.routeName;
  static const String register = ResgisterScreen.routeName;
  static const String forgetPassword = ForgetPasswordScreen.routeName;
  static const String homeNav = HomeNavBar.routeName;
  static const String homeTab = HomeTabs.routeName;
  static const String browseTab = BrowseTab.routeName;

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
     export: (context) => const ExportApp(),
    login: (context) => const LoginScreen(),
    register: (context) => const ResgisterScreen(),
    forgetPassword: (context) => const ForgetPasswordScreen(),
    homeNav: (context) => const HomeNavBar(),
    homeTab: (context) => const HomeTabs(),
    browseTab: (context) => const BrowseTab(),
  };
}
