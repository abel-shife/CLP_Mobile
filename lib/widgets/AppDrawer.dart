import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final Client client;

  const AppDrawer(this.client);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(0.0),
            child: Stack(
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 22.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/server/profileImages/${client.phoneNumber}.jpg',
                        ),
                        radius: 50,
                      ),
                      Text(
                        client.firstName + " " + client.lastName,
                        style:
                            TextStyle(color: Theme.of(context).primaryColor, fontSize: 22.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text(
              'Info',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            subtitle: Text('Profile Information'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/Profile", arguments: client);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.coins),
            title: Text(
              'Membership Status',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            subtitle: Text('Current loyalty Status'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/PointScreen", arguments: client);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.tasks),
            title: Text(
              'My Transactions',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            subtitle: Text('See Held Transactoins'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/Transactions", arguments: client);
            },
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text(
              'Feedback',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            subtitle: Text('Give comments and feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/FeedBack", arguments: client);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.signOutAlt),
            title: Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Are you sure to logout??'),
                        actions: [
                          FlatButton.icon(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, '/');
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.remove('client');
                              },
                              icon: Icon(Icons.check_circle),
                              label: Text('Yes')),
                          FlatButton.icon(
                            icon: Icon(Icons.cancel),
                            label: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ));
            },
          ),
        ],
      ),
    );
  }
}
