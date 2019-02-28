import "package:flutter/material.dart";

import './app_screens/first_screen.dart';

void main() => runApp(new MyFlutterApp());

class MyFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My Materaial App",
        home: Scaffold(
            appBar: AppBar(
              title: Text("My First app screen"),
            ),
            body: FirstScreen()));
  }
}
