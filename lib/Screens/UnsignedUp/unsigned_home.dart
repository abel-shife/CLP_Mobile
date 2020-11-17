
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UnsignedHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//
//      body: Container(
//        decoration: BoxDecoration(
//          gradient: getLinearGradient()
//        ),
//      ),
//    );
//  }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User Name',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
//      bottomNavigationBar: BottomBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Popular Items',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.only(top: 10, left: 10),
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              children: <Widget>[
//                for (int i = 0; i <= 5; i++)
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/image1.jpg'),
                            fit: BoxFit.contain),
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(20),
                            topStart: Radius.circular(20)),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[Text('sdfgh'),Row(
                          children: <Widget>[Text('sdfgh'),Text('sdfgh')],
                        )],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          onPressed: () {},
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          )),
    );
  }
}
