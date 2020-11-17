import 'dart:convert';

import 'file:///C:/abelProj/final_loyal/lib/AppServices/NetworkHandler.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/text_feild_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validators/validators.dart' as validator;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signUpFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Client client = Client();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  bool isFemale = false;
  bool isRequesting = false;
  bool showPassword = true;

  @override
  void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    birthDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
        floatingActionButton: FloatingActionButton(
          mini: true,
          tooltip: 'Clear All',
          onPressed: () {
            firstName.text = "";
            lastName.text = "";
            phoneNumber.text = "";
            email.text = "";
            password.text = "";
            confirmPassword.text = "";
            birthDate.text = "";
            setState(() {
              isFemale = false;
            });
          },
          child: Icon(Icons.clear_all),
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(gradient: getLinearGradient()),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w200),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Please register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/UnsignedHome');
                      },
                      icon: Icon(Icons.home),
                      color: Colors.white,
                      iconSize: 35.0,
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
                child: ListView(children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40),
                            bottom: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(40),
                                  bottom: Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [getBoxShadowProperty()]),
                          child: Form(
                            key: signUpFormKey,
                            autovalidate: true,
                            child: Column(children: <Widget>[
                              TextFieldBuilder(
                                controller: firstName,
                                labelText: 'first name',
                                prefixIcon: FontAwesomeIcons.signature,
                                onSaved: (String value) {
                                  client.firstName = value;
                                },
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Name can\'t be empty';
                                  }
                                  if (value.length < 2) {
                                    return 'Name must be atleast 2 letters';
                                  }
                                  return null;
                                },
                              ),
                              TextFieldBuilder(
                                controller: lastName,
                                labelText: 'last name',
                                prefixIcon: FontAwesomeIcons.signature,
                                onSaved: (String value) {
                                  client.lastName = value;
                                },
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Name can\'t be empty';
                                  }
                                  if (value.length < 2) {
                                    return 'Name must be atleast 2 letters';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: phoneNumber,
                                    decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        prefixIcon: Icon(Icons.phone_android),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0.0)),
                                    keyboardType: TextInputType.phone,
                                    onSaved: (String value) {
                                      client.phoneNumber = value;
                                    },
                                    validator: (String value) {
                                      if (!RegExp('^[+]{1}[0-9]{12,13}\$')
                                          .hasMatch(value)) {
                                        return "It contains country code and followed by phone number";
                                      }
                                      return null;
                                    },
                                  )),
                              TextFieldBuilder(
                                controller: email,
                                labelText: 'Email',
                                prefixIcon: Icons.email,
                                onSaved: (String value) {
                                  client.email = value;
                                },
                                validator: (String value) {
                                  if (!validator.isEmail(value)) {
                                    return "Not Valid email";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: password,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.lock_outline),
                                    suffix: InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                      child: Icon(showPassword?Icons.visibility:Icons.visibility_off),
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0.0)),
                                obscureText: showPassword,
                                onSaved: (String value) {
                                  client.password = value;
                                },
                                validator: (String value) {
                                  if (!RegExp('^[a-zA-Z0-9.]{8,32}\$')
                                      .hasMatch(value)) {
                                    return "Minimum of 8 charachters";
                                  }
                                  return null;
                                },
                              ),
                              TextFieldBuilder(
                                controller: confirmPassword,
                                labelText: 'Confirm Password',
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                validator: (String value) {
                                  if (password.text != value) {
                                    return "Password not confirmed";
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          40,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: birthDate,
                                        decoration: InputDecoration(
                                            labelText: 'Birth Date',
                                            prefixIcon: Icon(Icons.date_range),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0.0)),
                                        onSaved: (String value) {
                                          client.birthDate = value;
                                        },
                                        validator: (String value) {
                                          if (value == "")
                                            return "Birth date can't be null";
                                          return null;
                                        },
                                        onTap: () async {
                                          final DateTime pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1980),
                                            lastDate: DateTime.now(),
                                          );
                                          if (pickedDate != null) {
                                            birthDate.text = pickedDate
                                                .toString()
                                                .substring(0, 10);
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          40,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
//                                crossAxisAlignment: CrossAxisAlignment.,
                                        children: <Widget>[
                                          Text('Gender',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400)),
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Icon(FontAwesomeIcons.male),
                                              Switch(
                                                value: isFemale,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    isFemale = value;
                                                  });
                                                },
                                                activeTrackColor:
                                                    Colors.blueGrey,
                                                inactiveTrackColor:
                                                    Colors.blueGrey,
                                                inactiveThumbColor:
                                                    Colors.blueAccent,
                                              ),
                                              Icon(FontAwesomeIcons.female),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 8.0,
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
                                                    BorderRadius.circular(
                                                        50.0)),
                                            color:
                                                Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            child: Text(
                                              'Register',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                            onPressed: () async {
                                              if (signUpFormKey.currentState
                                                  .validate()) {
                                                client.isFemale = isFemale;
                                                signUpFormKey.currentState
                                                    .save();
                                                setState(() {
                                                  isRequesting = true;
                                                });
                                                var response =
                                                    await NetworkHandler.post(
                                                        'registerClient',
                                                        jsonEncode(<dynamic,
                                                            dynamic>{
                                                          'firstName':
                                                              client.firstName,
                                                          'lastName':
                                                              client.lastName,
                                                          'phoneNumber': client
                                                              .phoneNumber,
                                                          'email': client.email,
                                                          'password':
                                                              client.password,
                                                          'birthDate':
                                                              client.birthDate,
                                                          'isFemale':
                                                              client.isFemale,
                                                        }));
                                                switch (response.statusCode) {
                                                  case 201:
                                                    Navigator.pop(context);

                                                    Navigator.pushNamed(
                                                        context, '/Login',
                                                        arguments:
                                                            LoginScreenArguments(
                                                                client
                                                                    .phoneNumber,
                                                                true));
                                                    break;
                                                  case 403:
                                                    showSnackBar(
                                                        "Accont already exists");
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
                                        'Have account ? ',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, '/Login');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                          )),
                    ),
                  ),
                ]),
              ),
            ])));
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: ListView(
//        children: <Widget>[
//          SizedBox(
//            height: 50,
//          ),
//          Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Container(
//                //the image
//                width: 150,
//                height: 150,
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: DecorationImage(
//                        image: AssetImage('assets/images/image2.jpg'),
//                        fit: BoxFit.cover)),
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              Row(
//                children: <Widget>[
//                  Container(
//                    alignment: Alignment.topCenter,
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width / 2 - 10,
//                    child: TextFormField(
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.all(5),
//                        labelText: 'First Name',
//                        hintText: 'Enter Your First Name',
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    width: 10,
//                  ),
//                  Container(
//                    alignment: Alignment.topCenter,
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width / 2 - 10,
//                    child: TextFormField(
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.all(5),
//                        labelText: 'First Name',
//                        hintText: 'Enter Your First Name',
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 10,
//              ),
//              TextFormField(
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(5),
//                  labelText: 'Email',
//                  hintText: 'Enter Your Email',
//                ),
//              ),
//              SizedBox(
//                height: 10,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Container(
//                    width: 100,
//                    height: 61,
//                    child: DropdownButton(
//                      underline: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            'Country Code',
//                          ),
//                          Container(
//                            height: 0.5,
//                            width: 100,
//                            color: Colors.grey,
//                          )
//                        ],
//                      ),
//                      isExpanded: true,
//                      items: countries.map((String item) {
//                        return DropdownMenuItem<String>(
//                          value: item,
//                          child: (Text(item)),
//                        );
//                      }).toList(),
//                      onChanged: (value) {},
//                      value: countries[0],
//                    ),
//                  ),
//                  SizedBox(
//                    width: 10,
//                  ),
//                  Container(
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width - 120,
//                    child: TextFormField(
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.all(5),
//                        labelText: 'Phone Number',
//                        hintText: 'Enter Your Phone',
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    width: 10,
//                  ),
//                ],
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Container(
//                    width: 80,
//                    child: Text('Birth Date',style: TextStyle(fontSize: 18),),
//                  ),
//                  SizedBox(width: 10,),
//                  Container(
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width - 100,
//                    height: 50,
//                    child: CupertinoDatePicker(
//                      mode: CupertinoDatePickerMode.date,
//                      initialDateTime: DateTime.now(), onDateTimeChanged: (DateTime value) {},
//                    )
//                  ),
//                ],
//              )
//            ],
//          ),
//        ],
//      ),
////      body: (
////        child: Column(
//////        mainAxisAlignment: MainAxisAlignment.center,
//////        crossAxisAlignment: CrossAxisAlignment.center,
////          children: <Widget>[
////
////            Expanded(
////              child: Column(
////                children: <Widget>[
//////                TextFormField(
//////                  decoration: InputDecoration(
//////                    labelText: 'First Name',
//////                    hintText: 'Enter Your First Name',
//////                  ),
//////                ),
////                ],
////              ),
////            )
////          ],
////        ),
////      ),
//    );
  }

  void showSnackBar(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        action: SnackBarAction(
          label: "Close",
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: (Text(message))));
  }
}

class LoginScreenArguments {
  final String phoneNumber;
  final bool isFirstTime;

  LoginScreenArguments(this.phoneNumber, this.isFirstTime);
}
