import 'dart:async';

import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/models/getting_started.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/slideItem.dart';
import 'package:finalloyal/widgets/slide_dots.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatefulWidget {
  final Client client;

  const GettingStarted({Key key, this.client}) : super(key: key);
  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getLinearGradient()
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'The Loyal Hotel',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
              //The images for the getting started pages
              Expanded(
                  child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  InkWell(
                    child: PageView.builder(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: Slide.slideList.length,
                        onPageChanged: onPageChanged,
                        itemBuilder: (context, index) {
                          return SlideItem(index);
                        }),
                    onTap: () {

                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < Slide.slideList.length; i++)
                        if (currentPage == i)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  )
                ],
              )),
              //The buttons for sign up and login
              SizedBox(
                height: 16.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 12.0, left: 0.0),
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignUp');
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Center(
                    child: Text(
                      'Have an account? ',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 12.0, left: 0.0),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/Login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }
}
