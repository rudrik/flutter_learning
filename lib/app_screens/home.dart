import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.only(left: 10.0, top: 40.0),
            alignment: Alignment.center,
            color: Colors.deepPurple,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Spice jet",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "From Mumbai to Ahmedabad",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Air India",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "From Jaipur to Goa",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Indigo",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 25.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "From Goa to Ahmedabad",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
