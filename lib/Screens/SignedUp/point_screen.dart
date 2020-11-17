import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PointScreen extends StatelessWidget {
  final Client client;

  PointScreen(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.lastName + " " + client.lastName),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.gift),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          ClipPath(
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              height: 100,
            ),
            clipper: WaveClipperOne(),
          ),
          ClipPath(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
            ),
            clipper: WaveClipperTwo(),
          ),
          Column(
            children: [
              Text(
                '20.0',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                'Available Points',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Point History',
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                  child: ListView.builder(itemCount: 15, itemBuilder: (context, index) {
                    return  Card(
                      color: Colors.white,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        leading: Icon(FontAwesomeIcons.coins),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Service Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20.0),
                          ),
                        ),
                        subtitle: Text('10/10/2010'),
                        trailing: Column(
                          children: [
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              '+188.0',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20.0),
                            ),
                            Text('points'),
                          ],
                        ),
                        onTap: () {},
                      ),
                    );
                  },)
              )
            ],
          ),
//          Positioned(
//            top: 100,
//            child:
//          )
        ],
      ),

//      body: Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Column(
//          children: <Widget>[
//            Text(
//              'Hello, User',
//              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 32.0),
//            ),
//            Container(
//              color: Colors.grey,
//              height: 2.0,
//            ),
//            SizedBox(
//              height: 8.0,
//            ),
//            Text(
//              'Active Points:  150 ...use text.rich',
//              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
//            ),
//            SizedBox(
//              height: 8.0,
//            ),
//            Text(
//              'Used Points:  150 ...use text.rich',
//              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
//            ),
//            SizedBox(
//              height: 8.0,
//            ),
//            Text(
//              'Expired Points:  150 ...use ',
//              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
//            ),
//            SizedBox(
//              height: 8.0,
//            ),
//            Container(
//              color: Colors.grey,
//              height: 2.0,
//            ),
//          ],
//        ),
//      ),
    );
  }
}
