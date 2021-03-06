import 'package:flutter/material.dart';
import 'package:morningo/Models/BottomNavBarController.dart';
import 'package:morningo/Models/infoGathering.dart';
import 'package:morningo/Pages/ActivitiesPages/ExercisePageOld.dart';
import 'package:morningo/Pages/ActivitiesPages/JournalPage.dart';
// Activities Page
import 'package:morningo/Pages/ActivitiesPages/MeditationPage.dart';
import 'package:morningo/Pages/ActivitiesPages/PlanningPage.dart';
import 'package:morningo/Pages/HomePage.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/Account_page.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/Appearence_page.dart';
import 'package:morningo/Pages/SetupPage.dart';
import 'package:morningo/Pages/Splash_Screen.dart';
import 'package:morningo/Pages/authentication/login_page.dart';
// import 'package:morningo/Pages/HomePageAbsoluteNew.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class NavigatorController extends StatefulWidget {
  @override
  _NavigatorControllerState createState() => _NavigatorControllerState();
}

String collection = "";

class _NavigatorControllerState extends State<NavigatorController> {
  BuildContext buildContext;
  bool isFirstLaunched = false;

  bool test = false;
  String initialRouteVar = '/';

  void clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    collection = "";
  }

  @override
  void initState() {
    super.initState();
    setFirstlaunch();
    setState(() {});
  }

  void setFirstlaunch() async {
    isFirstLaunched =
        await InitialNavigationHandler().getFirstLaunch() ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {}); // Try Removing it
    return MaterialApp(
      key: UniqueKey(),
      routes: {
        '/': (context) =>
            LoginScreen(), //BottomNavController(), // HomePage, Instead goto  BottomBarPage
        '/splash': (context) => SplashScreen(),
        '/setup': (context) => LoginScreen(), //setuppage()
        // Activities Page
        '/Meditate': (context) => MeditationPage(),
        '/Exercise': (context) => ExcercisePageOld(),
        '/Plan': (context) => PlanningPage(),
        '/journal': (context) => JournalPage(),
        '/account': (context) => AccountPage(),
        // // Navigator Page
        // '/courses': (context) => CoursesPage(),
        // '/leaderboard': (context) => LeaderboardPage(),
        // '/settings': (context) => SettingsPage(),
      },
      initialRoute: isFirstLaunched ? '/' : '/setup',
    );
  }
}

class InitialNavigationHandler {
  Future<String> getCollection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    collection = await prefs.getString("@collectionName").toString();
    // print(collection.toString());
    return collection;
  }

  Future<bool> getFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    bool firstLaunch = await prefs.getBool("@firstLaunch");
    print(firstLaunch.toString());
    return firstLaunch;
  }
}

class TodoRouteController {
  void navigateHomeWithCollection(
      BuildContext context, InfoGateherer collection) async {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) {
          // return HomePage(
          //   gateherer: collection,
          //   contextOf: context,
          // );
          return BottomNavController(
            gateherer: collection,
            contextOf: context,
          );
        },
      ),
    );
  }
}

// Create Splash Screen Over Here
