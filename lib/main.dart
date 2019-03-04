import 'package:flutter/material.dart';

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
            body: getListView()));
  }
}

Widget getListView() {
  var listView = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.landscape),
        title: Text("Landscape"),
        subtitle: Text("Nice View"),
        trailing: Icon(Icons.wb_sunny),
        onTap: () {
          debugPrint("TAPPED!");
        },
      ),
      ListTile(
        leading: Icon(Icons.android),
        title: Text("Android"),
      ),
      ListTile(
        leading: Icon(Icons.devices),
        title: Text("Samsung"),
      ),
      Text("Another text element"),
      Container(color: Colors.red, height: 30.0)
    ],
  );
  return listView;
}
