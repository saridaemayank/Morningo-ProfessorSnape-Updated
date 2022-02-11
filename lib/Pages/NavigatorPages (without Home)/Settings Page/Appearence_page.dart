import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:morningo/Models/BottomNavBarController.dart';

void main() => runApp(Appearence_Page());

class Appearence_Page extends StatefulWidget {
  const Appearence_Page({Key key}) : super(key: key);

  @override
  _Appearence_PageState createState() => _Appearence_PageState();
}

class _Appearence_PageState extends State<Appearence_Page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute());
            },
            child: Icon(FeatherIcons.arrowLeft),
          ),
          title: Text('Appearence Page'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BottomNavController(),
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
