import 'package:flutter/material.dart';
import 'package:hendi_flutter_task/constants/global.dart';

import './ui/screens/course_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Involo Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.mainFont,
              color: AppColors.primaryText,
              height: 1),
          headline2: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontFamily: FontFamily.mainFont,
            color: AppColors.primaryText,
            height: 1,
          ),
          bodyText1: TextStyle(
            fontSize: 15.0,
            fontFamily: FontFamily.mainFont,
            color: AppColors.secondaryText,
            height: 1.2,
          ),
        ),
      ),
      home: CourseDetailsScreen(),
    );
  }
}
