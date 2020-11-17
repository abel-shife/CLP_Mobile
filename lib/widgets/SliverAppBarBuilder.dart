import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:flutter/material.dart';

class SliverAppBarBuilder extends StatefulWidget {
  final Client client;

  const SliverAppBarBuilder(this.client);

  @override
  _SliverAppBarBuilderState createState() => _SliverAppBarBuilderState();
}

class _SliverAppBarBuilderState extends State<SliverAppBarBuilder> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150.0,
      pinned: true,
      floating: true,
      elevation: 0.0,
      flexibleSpace: InkWell(
        child: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.only(bottom: 5.0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.client.firstName + " " + widget.client.lastName,
                ),
                Divider(
                  height: 5.0,
                  indent: 50.0,
                  endIndent: 50.0,
                  color: Theme.of(context).primaryColor,
                ),
                Text('Current Points ' + '100',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    )),
              ],
            ),
            background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/server/profileImages/${widget.client.phoneNumber}.jpg',
                        ),
                        fit: BoxFit.fill)),
                child: Container(
                  decoration: BoxDecoration(gradient: getImageGradient()),
                ))),
        onTap: () {
          Navigator.pushNamed(context, "/Profile", arguments: widget.client);
        },
      ),
    );
  }
}
