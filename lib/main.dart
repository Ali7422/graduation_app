// import 'package:firebase_core/firebase_core.dart'; // Firebase disabled
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:movies/firebase_options.dart'; // Firebase disabled
import 'package:movies/intro/routes/app_routes.dart';


import 'core/theme/app_theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const PodcastApp());
}

class PodcastApp extends StatelessWidget {
  const PodcastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
     designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
       routes: AppRoutes.routes,
        initialRoute: AppRoutes.splash,
      ),

    );
  }
}
