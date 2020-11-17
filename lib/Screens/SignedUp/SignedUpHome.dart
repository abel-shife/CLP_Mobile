import 'package:finalloyal/AppServices/SliverBarBuilderDelegate.dart';
import 'package:finalloyal/Screens/SignedUp/offer.dart';
import 'package:finalloyal/Screens/SignedUp/reward/rewardHome.dart';
import 'package:finalloyal/Screens/both/event.dart';
import 'package:finalloyal/Screens/both/service.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/AppDrawer.dart';
import 'package:finalloyal/widgets/SliverAppBarBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignedUpHome extends StatefulWidget {
  final Client client;

  SignedUpHome(this.client);

  @override
  _SignedUpHomeState createState() => _SignedUpHomeState();
}

class _SignedUpHomeState extends State<SignedUpHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, initialIndex: 0, vsync: this);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
        body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBarBuilder(widget.client),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegateBuilder(
                  TabBar(
                    controller: tabController,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.black26,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        icon: Icon(FontAwesomeIcons.gifts),
                        text: "Reward",
                      ),
                      Tab(
                        icon: Icon(Icons.loyalty),
                        text: "Offers",
                      ),
                      Tab(icon: Icon(Icons.event), text: "Events"),
                      Tab(icon: Icon(Icons.room_service), text: "Services"),
                    ],
                  ),
                  Colors.white,
                ),
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: [Reward(widget.client), Offer(), Event(), Service()],
          ),
        ),
        drawer: AppDrawer(widget.client),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.black,
              elevation: 10.0,
              child: Icon(Icons.keyboard_arrow_up),
              mini: true,
              onPressed: () {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent - 150,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.decelerate);
              },
            ),
            FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.black,
              elevation: 10.0,
              child: Icon(Icons.keyboard_arrow_down),
              mini: true,
              onPressed: () {
                scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.decelerate);
              },
            ),
          ],
        ));
  }

}

//speedDialBuilder(int activeTabIndex) {
//  switch (activeTabIndex) {
//    case 0:
//      return SpeedDial(
//        animatedIcon: AnimatedIcons.menu_close,
//        overlayColor: Colors.transparent,
//        children: [
//          SpeedDialChild(
//              child: Icon(Icons.sort_by_alpha), label: 'Name', onTap: () {}),
//          SpeedDialChild(
//              child: Icon(Icons.date_range), label: 'Date', onTap: () {}),
//        ],
//      );
//      break;
//    case 1:
//      return SpeedDial(
//        animatedIcon: AnimatedIcons.menu_close,
//        overlayColor: Colors.transparent,
//        children: [
//          SpeedDialChild(
//              child: Icon(Icons.sort_by_alpha), label: 'Name', onTap: () {}),
//          SpeedDialChild(
//              child: Icon(Icons.date_range), label: 'Date', onTap: () {}),
//        ],
//      );
//      break;
//
//    case 2:
//      return SpeedDial(
//        animatedIcon: AnimatedIcons.menu_close,
//        overlayColor: Colors.transparent,
//        children: [
//          SpeedDialChild(
//              child: Icon(Icons.sort_by_alpha),
//              label: 'Name',
//              onTap: () {
//                if (Event().eventsList != null)
//                  Event()
//                      .eventsList
//                      .sort((a, b) => a.eventName.compareTo(b.eventName));
//                debugPrint(Event().eventsList[0].toString());
//              }),
//          SpeedDialChild(
//              child: Icon(Icons.date_range),
//              label: 'Date',
//              onTap: () {
//                if (Event().eventsList != null)
//                  Event()
//                      .eventsList
//                      .sort((a, b) => a.eventDate.compareTo(b.eventDate));
//              }),
//        ],
//      );
//      break;
//    case 3:
//      return SpeedDial(
//        animatedIcon: AnimatedIcons.menu_close,
//        overlayColor: Colors.transparent,
//        children: [
//          SpeedDialChild(
//              child: Icon(Icons.sort_by_alpha), label: 'Name', onTap: () {}),
//          SpeedDialChild(
//              child: Icon(Icons.date_range), label: 'Date', onTap: () {}),
//        ],
//      );
//      break;
//  }
//}

