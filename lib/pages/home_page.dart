import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:greprestaurant/main.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _inputPassword = '';

  void _handleClickButton(int number) {
    print(number);
    setState(() {
      _inputPassword += number.toString();

      if (_inputPassword.length >= 4) {
        if (_inputPassword == '1234') {
          // navigate to next screen
          print('Password CORRECT!');
        } else {
          print('Password INCORRECT!');
          setState(() {
            _inputPassword = '';
          });
        }
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  _inputPassword.replaceAll(RegExp('[0-9]'), '*'),
                  style: GoogleFonts.prompt(fontSize: 30.0),
                ),
              ),
            ),
          ),
          Container(
              color: Color(0xFFFF0000),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var i in [1, 2, 3])
                        MyButton(
                          number: i,
                          withMargin: i == 3 ? false : true,
                          onClick: _handleClickButton,
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var i in [4, 5, 6])
                        MyButton(
                          number: i,
                          withMargin: i == 6 ? false : true,
                          onClick: _handleClickButton,
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (var i in [7, 8, 9])
                        MyButton(
                          number: i,
                          withMargin: i == 9 ? false : true,
                          onClick: _handleClickButton,
                        )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final int number;
  final bool withMargin;
  final Function onClick;

  const MyButton({
    Key key,
    this.number,
    this.withMargin = true,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: withMargin ? 10.0 : 0.0),
      decoration: BoxDecoration(
        border: Border.all(width: 5.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      width: 80.0,
      height: 80.0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onClick != null) onClick(number);
          },
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          child: Center(
              child: Text(
            number.toString(),
            style: GoogleFonts.prompt(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
  }
}
