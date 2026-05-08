import 'package:flutter/material.dart';
import 'package:movies/features/auth_feature/auth/login/login_screen.dart';
import 'package:movies/nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../onpoarding_screens/export_app.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
static const String routeName=" /splashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, ExportApp.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [

           Image.asset("assets/images/splash.png"),
         ],)

        ],
      ),
    );
  }
}