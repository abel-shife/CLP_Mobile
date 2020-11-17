import 'dart:convert';
import 'file:///C:/abelProj/final_loyal/lib/AppServices/NetworkHandler.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/text_feild_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final bool isFirstTime;
  final String phoneNumber;

  Login({this.phoneNumber, this.isFirstTime});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences preferences;
  final loginFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  Client client;
  var isRequesting = false;

  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    phoneNumber.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumber.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: getLinearGradient()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w200)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.isFirstTime == true
                            ? 'Account Created'
                            : 'Welcome Back',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    iconSize: 35.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                            bottom: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                                bottom: Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [getBoxShadowProperty()]),
                        child: Form(
                          key: loginFormKey,
                          autovalidate: true,
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: phoneNumber,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone_android),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0.0)),
                              keyboardType: TextInputType.phone,
                              validator: (String value) {
                                if (!RegExp('^[+]{1}[0-9]{12,13}\$')
                                    .hasMatch(value)) {
                                  return "It contains country code and followed by phone number";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                    child: Icon(showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0.0)),
                              obscureText: showPassword,
                              validator: (String value) {
                                if (!RegExp('^[a-zA-Z0-9.]{8,32}\$')
                                    .hasMatch(value)) {
                                  return "Minimum of 8 charachters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Forgot Password? ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'Click here',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                isRequesting
                                    ? CircularProgressIndicator(
                                        backgroundColor: Colors.red,
                                      )
                                    : Container(
                                        width: 180,
                                        child: RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.0,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          color: Theme.of(context).primaryColor,
                                          textColor: Colors.white,
                                          child: Text(
                                            'Login',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          onPressed: () async {
                                            if (loginFormKey.currentState
                                                .validate()) {
                                              setState(() {
                                                isRequesting = true;
                                              });
                                              var response =
                                                  await NetworkHandler.post(
                                                      'clientLogin',
                                                      jsonEncode(<dynamic,
                                                          dynamic>{
                                                        'phoneNumber':
                                                            phoneNumber.text,
                                                        'password':
                                                            password.text,
                                                      }));

                                              switch (response.statusCode) {
                                                case 201:
                                                  setState(() {
                                                    client = Client.fromJson(
                                                        jsonDecode(
                                                            response.body));
                                                    isRequesting = false;
                                                  });
                                                  preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  preferences.setString(
                                                      'client',
                                                      jsonEncode(client));
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(
                                                      context, '/SignedUpHome',
                                                      arguments: client);
                                                  break;
                                                case 404:
                                                  showSnackBar(
                                                      "Phone number doesn't exist");
                                                  setState(() {
                                                    isRequesting = false;
                                                  });
                                                  break;
                                                case 400:
                                                  showSnackBar(
                                                      "Incorrect password");
                                                  setState(() {
                                                    isRequesting = false;
                                                  });
                                                  break;
                                                default:
                                                  showSnackBar(
                                                      "Something went wrong, try again");
                                                  setState(() {
                                                    isRequesting = false;
                                                  });
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Don\'t have account ? ',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Create One',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, "/SignUp");
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        action: SnackBarAction(
          label: "Close",
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: (Text(message))));
  }
}
