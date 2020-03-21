import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'Constants.dart';

void main() => runApp(LocationApp());

class LocationApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: appDarkGreyColor,
      ),
      home: HomePage(),
    );
  }
}