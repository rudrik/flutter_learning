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

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.body1;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    controller: principalController,
                    decoration: InputDecoration(
                        labelText: 'Principal',
                        labelStyle: textStyle,
                        hintText: 'Enter Principal e.g. 12000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_minimumPadding),
                        )))),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextField(
                    style: textStyle,
                    controller: roiController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percent',
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
                        child: TextField(
                            style: textStyle,
                            controller: termController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Term',
                              labelStyle: textStyle,
                              hintText: 'Time in years',
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
                              showResult = _cauculateTotalReturns();
                              FocusScope.of(context).requestFocus(new FocusNode());
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

  String _cauculateTotalReturns() {
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
}
