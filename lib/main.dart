import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:movies/firebase_options.dart'; // Firebase disabled
import 'package:movies/intro/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'core/theme/app_theme.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: 'https://upzvtvmnztsyrhwomrrd.supabase.co',
    anonKey: 'sb_publishable_prSDxSxHlIQRRmGNVsm6xA_IQa2zesR',
  );

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
