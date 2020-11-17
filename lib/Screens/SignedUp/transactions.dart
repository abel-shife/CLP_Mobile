import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Transactions extends StatelessWidget {
  final Client client;

  Transactions(this.client);

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
                'Transaction History',
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
                      leading: Icon(FontAwesomeIcons.tasks),
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
                            '188.0',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20.0),
                          ),
                          Text('price'),
                        ],
                      ),
                      onTap: () {},
                    ),
                  );
                },)
              )
            ],
          ),
        ],
      ),
    );
  }
}
