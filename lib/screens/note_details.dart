import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';
import '../utils/database_helper.dart';

class NoteDetails extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetails(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteDetailsState(this.note, this.appBarTitle);
  }
}

class NoteDetailsState extends State<NoteDetails> {
  static var _priorities = ['High', 'Low'];

  var _formKey = GlobalKey<FormState>();

  DatabaseHelper databaseHelper = DatabaseHelper();
  String appBarTitle;
  var _userSelectedValue = '';
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailsState(this.note, this.appBarTitle);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userSelectedValue = _priorities[1];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;

    titleController.text = note.title;
    descriptionController.text = note.description;

    titleController.addListener(() => onTitleChange());
    descriptionController.addListener(() => onDescriptionChange());

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }),
          ),
          body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: DropdownButton(
                          items: _priorities.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          style: textStyle,
                          value: getPriorityAsString(note.priority),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              debugPrint('User Selected $valueSelectedByUser');
                              updatePriorityAsInt(valueSelectedByUser);
                            });
                          }),
                    ),
                    //Second Element
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: titleController,
                        style: textStyle,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please write title';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    //Third element
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextFormField(
                        controller: descriptionController,
                        style: textStyle,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please write Description';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    //Fourth Element
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    _save();
                                  }
                                });
                              },
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Save',
                                textScaleFactor: 1,
                              ),
                            ),
                          ),
                          Container(
                            width: 5.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  debugPrint('Delete Pressed!');
                                  _delete();
                                });
                              },
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Delete',
                                textScaleFactor: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

// Convert String priority in the form of Integer before saving it to database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

// Convert int priority to String priority and display it to user DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; //'High'
        break;
      case 2:
        priority = _priorities[1]; // 'Low'
        break;
    }
    return priority;
  }

// Update the title of Note object
  void updateTitle() {
    note.title = titleController.text;
  }

//Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (note.id != null) {
      //Case 1: Update Operation
      result = await databaseHelper.updateNote(note);
    } else {
      result = await databaseHelper.insertNote(note);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: if User is trying to delete the New Note.
    if (note.id == null) {
      _showAlertDialog('Status', 'No note was deleted');
      return;
    }

    // Case 2 : User is trying to delete the old note that already has a valid ID
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  onTitleChange() {
    updateTitle();
  }

  onDescriptionChange() {
    updateDescription();
  }
}
