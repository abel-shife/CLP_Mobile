import 'dart:convert';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/AppServices/Debouncer.dart';
import 'package:finalloyal/AppServices/NetworkHandler.dart';
import 'package:finalloyal/animations/Shimmers.dart';
import 'package:finalloyal/models/offers_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  SharedPreferences preferences;
  AllOffers allOffers;
  List<Offers> offersList;
  List<Offers> filteredOffersList;
  final AsyncMemoizer memoizer = AsyncMemoizer();
  final Debouncer debouncer = Debouncer(500);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchOffers(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                networkErrorShimmerBuilder(),
              ],
            );
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.waiting:
            return listShimmerBuilder();
            break;
          case ConnectionState.done:
            if (snapshot.hasError)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  networkErrorShimmerBuilder(),
                ],
              );
            else
              return offerBuilder();
            break;
        }
        return null;
      },
    );
  }

  RefreshIndicator offerBuilder() {
    return RefreshIndicator(
      onRefresh: refreshOffers,
      child: offersList!=null? Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: getElevationProperty(),
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.search),
                    Expanded(
                      child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 15),
                              hintText: "Start Date or Title",
                              filled: false,
                              border: InputBorder.none),
                          onChanged: (value) {
                            debouncer.run(() {
                              setState(() {
                                filteredOffersList = offersList
                                    .where((element) => (element.offerTitle
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        element.startDate
                                            .toLowerCase()
                                            .contains(value.toLowerCase())))
                                    .toList();
                              });
                            });
                          }),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                      color: Theme.of(context).primaryColor,
                      indent: 7.0,
                      endIndent: 7.0,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            filteredOffersList.sort(
                                (a, b) => a.offerTitle.compareTo(b.offerTitle));
                          });
                          Fluttertoast.showToast(
                              msg: "Sorted By Name",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Icon(Icons.sort_by_alpha)),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            filteredOffersList.sort(
                                (a, b) => a.startDate.compareTo(b.startDate));
                          });
                          Fluttertoast.showToast(
                              msg: "Sorted By Start Date",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Icon(Icons.date_range)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  itemCount: filteredOffersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/OfferDetail",
                            arguments:
                                OfferScreenArgument(index, filteredOffersList));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                              height: 170.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(80.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                filteredOffersList[index]
                                                    .offerTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                filteredOffersList[index]
                                                    .selectedServiceSubCatagory,
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              calculateLeftDays(
                                                  filteredOffersList[index]
                                                      .startDate),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.0,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'days left',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          filteredOffersList[index]
                                                  .discountPercent.round()
                                                  .toString() +
                                              " % , " +
                                              filteredOffersList[index]
                                                  .discountPrice
                                                  .round()
                                                  .toString() +
                                              " ETB DISC",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                        ),
                                        Text('tap for details')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20.0,
                              top: 15.0,
                              bottom: 15.0,
                              child: Hero(
                                tag: index,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    width: 90.0,
                                    placeholder: (context, url) {
                                      return imagePlaceHolder();
                                    },
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/client/src/assets/images/dashboard.png',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ): Center(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.black,
                direction: ShimmerDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.arrow_back_ios,size: 30.0,),
                    Text('There are no ',style: TextStyle(fontSize: 18.0),),
                  ],
                ),
              ),

              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.black,
                direction: ShimmerDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('offers available', style: TextStyle(fontSize: 18.0),),
                    Icon(Icons.arrow_forward_ios,size: 30.0,),
                  ],
                ),
              ),
            ],
          ))
    );
  }

  Future<void> fetchOffers() {
//    CheckConnection.isConnected().then((value) async {
//      if (value) {
    return this.memoizer.runOnce(() async {
      var response = await NetworkHandler.get('getAllOffers');

      var decodedResponse = jsonDecode(response.body);
      allOffers = AllOffers.fromJson(decodedResponse);
      offersList = allOffers.allOffers;
      filteredOffersList = offersList;
    });

//        saveOffers();
//      } else {
//        loadOffers();
//      }
//    });
  }

  Future<void> refreshOffers() async {
//    CheckConnection.isConnected().then((value) async {
//      if (value) {
    var response = await NetworkHandler.get('getAllOffers');

    var decodedResponse = jsonDecode(response.body);
    allOffers = AllOffers.fromJson(decodedResponse);
    offersList = allOffers.allOffers;
    filteredOffersList = offersList;
    searchController.clear();
    setState(() {});
//        saveOffers();
//      } else {
//        loadOffers();
//      }
//    });
  }

  saveOffers() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList('offers') != null)
      preferences.remove('offers');
    preferences.setStringList('offers',
        offersList.map((offer) => jsonEncode(Offers.toMap(offer))).toList());
  }

  loadOffers() async {
    preferences = await SharedPreferences.getInstance();

    List<String> tempOffer = preferences.getStringList('offers');
    offersList =
        tempOffer.map((item) => Offers.fromJson(jsonDecode(item))).toList();
  }

  String calculateLeftDays(String offerStartingDate) {
    return new DateTime.now()
        .difference(DateTime.parse(offerStartingDate))
        .inDays
        .toString();
  }
}

class OfferScreenArgument {
  final int index;
  final List<Offers> offersList;

  OfferScreenArgument(this.index, this.offersList);
}
