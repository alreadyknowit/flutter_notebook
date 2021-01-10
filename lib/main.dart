import 'package:flutter/material.dart';
import 'package:flutter_project_intellij/database_connection.dart';
import 'package:flutter_project_intellij/screens/homePage.dart';
import 'package:sqflite/sqflite.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),

    );
  }
}