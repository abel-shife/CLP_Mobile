import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Reward extends StatefulWidget {
  final Client client;

  const Reward(this.client);

  @override
  _RewardState createState() => _RewardState();
}

class _RewardState extends State<Reward> {
//  onSort(int columnIndex, bool ascending) {
//    if (columnIndex == 0) {
//      if (ascending) {
//        sno.sort((a, b) => a.compareTo(b));
//        itemList = itemList.reversed.toList();
//      } else {
//        sno.sort((b, a) => a.compareTo(b));
//        itemList = itemList.reversed.toList();
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.white,
              elevation: 5.0,
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/client/src/assets/images/dashboard.png'),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Recommended Rewards',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
                  ),
                ),
                subtitle: Text(
                    'These are rewards that we recommend to you to redeem'),
                onTap: () {
                  Navigator.pushNamed(context, '/rewardTabIndex',
                      arguments: RewardTabScreenArgument(0, widget.client));
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.white,
              elevation: 5.0,
              child: ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image1.jpg'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Available Rewards',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0),
                    ),
                  ),
                  subtitle: Text(
                      'These are rewards that you can redeem with your current point.'),
                  onTap: () {
                    Navigator.pushNamed(context, '/rewardTabIndex',
                        arguments: RewardTabScreenArgument(1, widget.client));
                  }),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              color: Colors.white,
              elevation: 5.0,
              child: ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/image1.jpg'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Rewards for the Future',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20.0),
                    ),
                  ),
                  subtitle: Text(
                      'These are rewards that you can redeem after collecting more points'),
                  onTap: () {
                    Navigator.pushNamed(context, '/rewardTabIndex',
                        arguments: RewardTabScreenArgument(2, widget.client));
                  }),
            ),
          ],
        ),
      ],
    );
  }
}

class RewardTabScreenArgument {
  final int index;
  final Client client;

  RewardTabScreenArgument(this.index, this.client);
}
