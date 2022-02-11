import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:morningo/Pages/Splash_Screen.dart';
import 'package:morningo/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

/*
   TODO:l
   1) One Time, On Null showing on Activities other times its not fix it to show only once (DONE)
   2) Bug Fix: SharedPreference on TodoCard How Many Left, Activities Time 
   3) Pop UP Box, When Morning Star Adds
   4) Fucking BUG ABOUT THE DICK BUTTONS NOT WORKING! (DONE) (FIXED)

    //var date = DateTime.now(); 
  var newDate = DateTime.yesterday(); // get this from the SharedPrefrence,  
  final difference = date / newDate.difference(date / newDate).inHours;
  print("Time Differece: ${difference * -1} Hours");
    
  if (difference == 0) {
    print("Time To Change!"); // Unlock Another Wake Up Time
  }

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => GoogleSignInProvider(),
      child: GetMaterialApp(
        // themeMode: ThemeMode.system,
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(
            context,
            widget,
          ),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(500, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
          ],
          background: Container(
            color: Color(0xFFF5F5F5),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: AppSplashScreen(),
      ),
    ),
  );
}
