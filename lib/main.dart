import 'dart:async';

import 'package:flutter/material.dart';

import './screens/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoteKeeper",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: NoteList(),
    );
  }
}

printFileContent() async {
  String fileContent = await downLoadFile();
}

Future<String> downLoadFile() {
  Future<String> result = Future.delayed(Duration(seconds: 6), () {
    return 'My file content';
  });

  return result;
}
