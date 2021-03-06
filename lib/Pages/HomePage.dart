import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/MoodState.dart';
// Models / Utils
import "../Models/Time.dart";
import '../Models/globalHandler.dart';
import '../Models/infoGathering.dart';
// components
import '../components/todoGenerator.dart';

// Variables Important:

// nameOfUser
// morningStar
//  '$hour : $min $clock',
//_showMoodPanel(/context, good, neutral, bad);

class MyNewApp extends StatefulWidget {
  @override
  _MyNewAppState createState() => _MyNewAppState();
}

class _MyNewAppState extends State<MyNewApp> {
  var context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  InfoGateherer gateherer;
  // New
  BuildContext contextOf;

  HomePage({
    Key key,
    this.gateherer,
    this.contextOf,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool good = false;
  bool neutral = false;
  bool bad = false;
  User result = FirebaseAuth.instance.currentUser;

  var hour = 0;
  var min = 0;
  var clock = "AM";
  // ignore: non_constant_identifier_names
  var currentIndex_ = 1;
  var morningStar = 0;

  // WIDTH

  Time time = Time();
  String globalTime = "";

  MoodState moodState;
  // DateTime dateTime;
  GlobalHandler handler = GlobalHandler();
  String nameOfUser;

  // ignore: non_constant_identifier_names
  final Widget no_activities_svg = SvgPicture.asset(
    'Assets/SVG/undraw_Faq_re_31cw.svg',
    semanticsLabel: 'Acme Logo',
    width: 600,
    height: 600,
  );

  // ignore: non_constant_identifier_names
  @override
  void initState() {
    super.initState();

    // Variable Initialization

    setupMorningStars(context);
    setupCollections();
    // GlobalMorningStarHandler().setGlobalMorningStarConstant(100);
    setupTime(context);
  }

  void clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void setupCollections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString("@collectionName");
    nameOfUser = userName.toString();
    setState(() {});
  }

  void setupTime(context) async {
    // ignore: non_constant_identifier_names
    var futureTime_ = time.GetTime();
    futureTime_.then((value) => () {
          var time_ = value;
          print(time_);
          hour = int.parse(time_.split(':')[0]);
          min = int.parse(time_.split(':')[1]);
          clock = time_.split(':')[2];
          setState(() {});
        });
  }

  void setupMorningStars(context) async {
    // ignore: await_only_futures
    GlobalMorningStarHandler().getMorningStar().then((value) {
      if (morningStar == null) morningStar = 0;
      morningStar = value;
    });
    print(morningStar);
    if (morningStar == null || morningStar == 0) {
      GlobalMorningStarHandler().setMorningStar(0);
    } else {
      GlobalMorningStarHandler().setMorningStar(morningStar);
    }
    print("Morning Star Amount: $morningStar");
    if (morningStar == null) morningStar = 0;
    // Need to check some other way that it came from somewhere else
    setState(() {});
  }

  // ignore: missing_return
  Widget clearAllActivities() {
    // morningStar += 100;
    return Center(child: no_activities_svg);
  }

  @override
  Widget build(BuildContext context) {
    // Done Command
    void doneCommand(BuildContext context) {
      Navigator.of(context).pop();
      if (moodState == null) return;
      if (TodoController().getAllTodoLenght() != 0) return;
      // Take Time, If this tommorow Time, then only do it
      setState(() {
        TodoGen().generateTodo();

        if (moodState.good == true) {
          String initialTime = time.habitTimeSetter(20);
          String initialTimeRefined = initialTime.split(" ")[0];
          hour = int.parse(initialTimeRefined.split(':')[0]);
          min = int.parse(initialTimeRefined.split(':')[1]);
          clock = initialTime.split(" ")[1];
          globalTime = "$hour:$min:$clock";
          handler.setTime(globalTime);
        }
        if (moodState.neutral == true) {
          String initialTime = time.moodNeutral(20);
          String initialTimeRefined = initialTime.split(" ")[0];
          hour = int.parse(initialTimeRefined.split(':')[0]);
          min = int.parse(initialTimeRefined.split(':')[1]);
          clock = initialTime.split(" ")[1];
          globalTime = "$hour:$min:$clock";
          handler.setTime(globalTime);
        }
        if (moodState.bad == true) {
          // Change the algorithm
          String initialTime = time.moodBad(30);
          String initialTimeRefined = initialTime.split(" ")[0];
          hour = int.parse(initialTimeRefined.split(':')[0]);
          min = int.parse(initialTimeRefined.split(':')[1]);
          clock = initialTime.split(" ")[1];
          globalTime = "$hour:$min:$clock";
          handler.setTime(globalTime);
        }

        setState(() {});
      });
    }

    void _showMoodPanel(
        BuildContext context, bool goodMood, bool neutralMood, bool badMood) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "How Was Your Mood?",
                        textScaleFactor: 1.8,
                        style: TextStyle(
                            fontFamily: 'Caviar Dreams',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            good = !good;
                            neutral = false;
                            bad = false;
                            moodState = MoodState(good, neutral, bad);
                            Navigator.of(context).pop();
                            _showMoodPanel(context, good, neutral, bad);
                          },
                          child: Column(
                            children: [
                              Text(
                                "????",
                                style: TextStyle(fontSize: 40),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Good")
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: good ? Border.all(color: Colors.blue) : null,
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            good = false;
                            neutral = !neutral;
                            bad = false;
                            moodState = MoodState(good, neutral, bad);
                            Navigator.of(context).pop();
                            _showMoodPanel(context, good, neutral, bad);
                          },
                          child: Column(
                            children: [
                              Text(
                                "????",
                                style: TextStyle(fontSize: 40),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Neutral")
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: neutral
                                ? Border.all(color: Colors.blue)
                                : null),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            good = false;
                            neutral = false;
                            bad = !bad;
                            moodState = MoodState(good, neutral, bad);
                            Navigator.of(context).pop();
                            _showMoodPanel(context, good, neutral, bad);
                          },
                          child: Column(
                            children: [
                              Text(
                                "????",
                                style: TextStyle(fontSize: 40),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Bad")
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                bad ? Border.all(color: Colors.blue) : null),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      splashColor: Colors.amber,
                      //radius: ,
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.purple,
                        ),
                        //margin: EdgeInsets.all(35),
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Text(
                          "Done",
                          textScaleFactor: 1.4,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        doneCommand(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    // Pop Up Morning Star Goes Here

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // bottomNavigationBar: ClipRRect(
        //   borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(28),
        //     topLeft: Radius.circular(28),
        //   ),
        //   child: SizedBox(
        //     height: 110,
        //     child: BottomNavigationBar(
        //       currentIndex: currentIndex_,
        //       enableFeedback: true,
        //       unselectedItemColor: const Color(0xffdbdbdb),
        //       backgroundColor: Colors.white,
        //       type: BottomNavigationBarType.fixed,
        //       items: [
        //         BottomNavigationBarItem(icon: Icon(Icons.school), label: ''),
        //         BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        //         BottomNavigationBarItem(icon: Icon(Icons.public), label: ''),
        //         BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
        //       ],
        //       selectedItemColor: Color(0xffb0a4fb),
        //       showSelectedLabels: false,
        //       showUnselectedLabels: false,
        //       elevation: 0,
        //       onTap: (index) {
        //         setState(() {
        //           currentIndex_ = index;
        //           print(currentIndex_);
        //           if (currentIndex_ == 0) {
        //             Navigator.pushNamed(context, '/courses');
        //           }
        //           if (currentIndex_ == 1) {
        //             Navigator.pushNamed(context, '/');
        //           }
        //         });
        //       },
        //     ),
        //   ),
        // ),
        extendBody: true,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 10, bottom: 5),
                        child: Text(
                          'Good Morning',
                          style: TextStyle(
                            fontFamily: 'Caviar Dreams',
                            fontSize: 17,
                            color: const Color(0xffc0becc),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40, left: 130, right: 5),
                        child: Icon(FeatherIcons.sun),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Text(
                          '$morningStar',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 23,
                            color: const Color(0xfffba4a4),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 40, left: 10),
                    padding: EdgeInsets.all(0),
                    child: Text(
                      '$nameOfUser',
                      style: TextStyle(
                        fontFamily: 'Caviar Dreams',
                        fontSize: 32,
                        color: const Color(0xffb0a4fb),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 75, left: 0),
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      '$hour:$min $clock',
                      style: TextStyle(
                        fontFamily: 'Caviar Dreams',
                        fontSize: 40,
                        color: const Color(0xffce97b0),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 140, left: 10),
                    child: Text(
                      'Courses Enrolled / Stats',
                      style: TextStyle(
                        fontFamily: 'Caviar Dreams',
                        fontSize: 20,
                        color: const Color(0xffc0becc),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 175, left: 10),
                    width: 222,
                    height: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xfffbc6a4),
                    ),
                  ),
                ],
              ),
              // Expanded ScrollBar!
              Center(
                heightFactor: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 17),
                  child: GestureDetector(
                    onTap: () {
                      // HERE PEOPLE WILL NOT RUN IT!
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return MorningPopUp().openPopup(context, 140);
                      //   },
                      // );
                      _showMoodPanel(context, good, neutral, bad);
                    },
                    child: Container(
                      // width: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(47.0),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff404b69)),
                      ),
                      child: Text(
                        'Wake Up',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: const Color(0xff283149),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 0,
                    right: MediaQuery.of(context).size.width * 0.67,
                    bottom: 0),
                child: Text(
                  'Activities',
                  style: TextStyle(
                    fontFamily: 'Caviar Dreams',
                    fontSize: 20,
                    color: const Color(0xffc0becc),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                child: Expanded(
                  flex: 1,
                  child: Scrollbar(
                    hoverThickness: 0,
                    thickness: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(top: 10, bottom: 0),
                      child: TodoController().getAllTodoLenght() == 0
                          ? clearAllActivities()
                          : TodoGenerator(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
