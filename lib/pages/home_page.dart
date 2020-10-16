import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greprestaurant/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greprestaurant/pages/food_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const PASSWORD_LENGTH = 4;
  String _inputPassword = '';

  void _handleClickButton(int number) {
    print(number);

    setState(() {
      _inputPassword += number.toString();

      if (_inputPassword.length >= PASSWORD_LENGTH) {
        if (_inputPassword == '1234') {
          // navigate to next screen
          print('Password CORRECT!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FoodListPage(),
            ),
          );
        } else {
          print('Password INCORRECT!');
          Fluttertoast.showToast(
              msg: "รหัสผ่านไม่ถูกต้อง",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 16.0
          );
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
                /*child: Text(
                  _inputPassword.replaceAll(RegExp('[0-9]'), '*'),
                  style: GoogleFonts.prompt(fontSize: 30.0),
                ),*/
                child: SizedBox(
                  width: 160.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      for (var i = 0; i < _inputPassword.length; i++)
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      for (var i = 0; i < PASSWORD_LENGTH - _inputPassword.length; i++)
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
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
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyButton(
                      number: 0,
                      withMargin: false,
                      onClick: _handleClickButton,
                    )
                  ],
                ),
              ],
            ),
          ),
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
        border: Border.all(width: 5.0, color: Colors.black.withOpacity(0.2)),
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
