import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morningo/Models/BottomNavBarController.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/Account_page.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/Appearence_page.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/Help_and_support.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/learning_progress.dart';
import 'package:morningo/Pages/NavigatorPages%20(without%20Home)/Settings%20Page/stats_page.dart';
import 'package:morningo/Pages/authentication/login_page.dart';

class SettingsPage extends StatelessWidget {
  GoogleSignInAccount user;
  GoogleSignInAccount get user1 => user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 60.0, top: 40.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Caviar Dreams',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40.0, right: 50.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 250.0),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          fontFamily: 'Caviar Dreams',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(FeatherIcons.arrowRight),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute1());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40.0, right: 50.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 281.0),
                      child: Text(
                        'Stats',
                        style: TextStyle(
                          fontFamily: 'Caviar Dreams',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(FeatherIcons.arrowRight),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute2());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40.0, right: 50.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 158.0),
                      child: Text(
                        'Learning Progress',
                        style: TextStyle(
                          fontFamily: 'Caviar Dreams',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(FeatherIcons.arrowRight),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute3());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40.0, right: 50.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 207.0),
                      child: Text(
                        'Appearence',
                        style: TextStyle(
                          fontFamily: 'Caviar Dreams',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(FeatherIcons.arrowRight),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute4());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40.0, right: 50.0),
              child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 108.0),
                      child: Text(
                        'Help Desk and Support',
                        style: TextStyle(
                          fontFamily: 'Caviar Dreams',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(FeatherIcons.arrowRight),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute5());
            },
            child: Container(
              height: 60,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Color(0xffffffff),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontFamily: 'Caviar Dreams',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AccountPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute1() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Stats_Page(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        Learning_Progress_Screen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute3() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Appearence_Page(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute4() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        HelpDesk_and_Support(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute5() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
