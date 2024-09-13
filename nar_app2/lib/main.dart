import 'package:flutter/material.dart';
import 'package:nar_app2/screens/main_page.dart';
import 'models/db_connect.dart';

void main() {
  var db = DBconnect();

  db.fetchQuestions();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
