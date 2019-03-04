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
            body: getLongListView()));
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

List<String> getListElements() {
  var items = List<String>.generate(1000, (counter) => "Item $counter");
  return items;
}

Widget getLongListView() {
  var listItem = getListElements();
  var listView = ListView.builder(itemBuilder: (context, index) {
    if (index < listItem.length)
      return ListTile(
        leading: Icon(Icons.arrow_right),
        title: Text(listItem[index]),
        onTap: () {
          debugPrint('${listItem[index]} was tapped');
        },
      );
  });

  return listView;
}
