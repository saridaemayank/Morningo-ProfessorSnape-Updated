import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:morningo/Models/BottomNavBarController.dart';
import 'package:morningo/Models/NavigatorController.dart';
import 'package:morningo/Models/infoGathering.dart';
import 'package:morningo/Pages/authentication/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SetupPage extends StatefulWidget {
  static const String id = 'setup_screen';
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  String nameOf;
  String finalEmail;
  String age;
  // ignore: non_constant_identifier_names
  String average_fall_asleep_time;
  String sleepTime;
  String wakeTime;

  void navigate() async {
    InfoGateherer collector = InfoGateherer(
      nameOf,
      int.parse(age),
      average_fall_asleep_time,
      sleepTime,
      wakeTime,
    );
    // Set All Things In Variable; Maybe Put All This In String!

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("@collectionName", collector.name);

    prefs.setBool("@firstLaunch", true);
    TodoRouteController().navigateHomeWithCollection(context, collector);
    print(nameOf);
  }
  /*
  by saving a boolean inside shared preferences pub.dev/packages/shared_preferences, 
  it will be null at first, then after the first launch s et it to true, 
  after that check for that value and display widgets based on it – Basel Abuhadrous Aug 
  */

  @override
  final _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();

  TimeOfDay time = const TimeOfDay(hour: 12, minute: 12);

  final snackbar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.error_outline,
          size: 32,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            'Fill in all the fields',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.red,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top: 120),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Setup',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 35,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What do people call you?',
                      labelText: 'Name *',
                    ),
                    onChanged: (context) {
                      nameOf = context.characters.toString();
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.height),
                      hintText: 'What is your age?',
                      labelText: 'Age *',
                    ),
                    onChanged: (context) {
                      age = context.characters.toString();
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock_clock),
                      hintText: 'Your Average Fall Asleep Time',
                      labelText: 'Fall Time',
                    ),
                    onChanged: (context) {
                      average_fall_asleep_time = context.characters.toString();
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.bed),
                      hintText: 'Average Wake Up Time',
                      labelText: 'Wake Up Time *',
                    ),
                    onChanged: (context) {
                      wakeTime = context.characters.toString();
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.snooze),
                      hintText: 'Sleep Time',
                      labelText: 'When do you go to sleep at Night? *',
                    ),
                    onChanged: (context) {
                      sleepTime = context.characters.toString();
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 212,
                    height: 66,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33.0),
                      color: const Color(0xffff0000),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29212020),
                          offset: Offset(0, 12),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () async {
                        if (nameOf == null ||
                            age == null ||
                            average_fall_asleep_time == null ||
                            sleepTime == null ||
                            wakeTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          navigate();
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontFamily: 'Gotham',
                          fontSize: 25,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTimePicker() => SizedBox(
        height: 108,
        child: CupertinoDatePicker(
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 10,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  DateTime getDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.day, now.month, now.hour, 10);
  }
}
