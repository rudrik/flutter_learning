import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest calculator App",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _minimumPadding = 5.0;
  var _defaultCurrencies = 'Rupees';

  var _currentlyItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentlyItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var showResult = '';

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body1;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
//        margin: EdgeInsets.all(_minimumPadding * 2),
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter principal amount';
                        } else if (!isNumeric(value)) {
                          return 'Please enter value in number';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          labelStyle: textStyle,
                          hintText: 'Enter Principal e.g. 12000',
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(_minimumPadding),
                          )))),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                      style: textStyle,
                      controller: roiController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter rate of interest';
                        } else if (!isNumeric(value)) {
                          return 'Please enter value in number';
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'In percent',
                        errorStyle: TextStyle(
                            color: Colors.yellowAccent, fontSize: 15.0),
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_minimumPadding),
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                              style: textStyle,
                              controller: termController,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter time';
                                } else if (!isNumeric(value)) {
                                  return 'Please enter value in number';
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Term',
                                labelStyle: textStyle,
                                hintText: 'Time in years',
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(_minimumPadding),
                                ),
                              ))),
                      Container(
                        width: _minimumPadding * 5,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentlyItemSelected,
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                      ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: _minimumPadding * 5),
                        child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1,
                            ),
                            onPressed: () {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                if (_formKey.currentState.validate()) {
                                  showResult = _calculateTotalReturns();
                                }
                              });
                            }),
                      )),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.only(left: _minimumPadding * 5),
                            child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  'Reset',
                                  textScaleFactor: 1,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _reset();
                                  });
                                })),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(_minimumPadding),
                child: Text(
                  this.showResult,
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/ic_dislike.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentlyItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your return will be $totalAmountPayable $_currentlyItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    showResult = '';
    _currentlyItemSelected = _currencies[0];
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.parse(value, (e) => null) != null ||
        int.parse(value, onError: (e) => null) != null;
  }
}
