import 'package:finalloyal/AppServices/SliverBarBuilderDelegate.dart';
import 'package:finalloyal/Screens/SignedUp/reward/availableRewards.dart';
import 'package:finalloyal/Screens/SignedUp/reward/futureRewards.dart';
import 'package:finalloyal/Screens/SignedUp/reward/recommendedRewards.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/AppDrawer.dart';
import 'package:finalloyal/widgets/SliverAppBarBuilder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RewardTabIndex extends StatefulWidget {
  final int tabIndex;
  final Client client;

  RewardTabIndex(this.tabIndex, this.client);

  @override
  _RewardTabIndexState createState() => _RewardTabIndexState();
}

class _RewardTabIndexState extends State<RewardTabIndex>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(vsync: this, length: 3, initialIndex: widget.tabIndex);
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    scrollController.dispose();
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
                        text: "Recommended",
                      ),
                      Tab(
                        icon: Icon(Icons.loyalty),
                        text: "Available",
                      ),
                      Tab(icon: Icon(Icons.event), text: "Future"),
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
            children: [
              RecommendedRewards(),
              AvailableRewards(),
              FutureRewards(),
            ],
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
