import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:flutter/material.dart';

class AvailableRewards extends StatefulWidget {
  @override
  _AvailableRewardsState createState() => _AvailableRewardsState();
}

class _AvailableRewardsState extends State<AvailableRewards> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchGeneralRewards(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('fgd');
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColorLight,
              ),
            );
            break;
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(child: Text("error" + snapshot.error.toString()));
            else
              return generalRewardsBuilder();
            break;
        }
        return null;
      },
    );
  }

  RefreshIndicator generalRewardsBuilder() {
    return RefreshIndicator(
        onRefresh: fetchGeneralRewards,
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: getElevationProperty(),
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.menu),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15, right: 15),
                              hintText: "Search Events",
                              filled: false,
                              border: InputBorder.none),
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2.0,
                        color: Theme.of(context).primaryColor,
                        indent: 7.0,
                        endIndent: 7.0,
                      ),
                      InkWell( onTap: (){}, child: Icon(Icons.sort_by_alpha)),
                      SizedBox(
                        width: 20.0,
                      ),
                      InkWell(onTap: (){}, child: Icon(Icons.date_range)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
//                    Navigator.pushNamed(context, "/OfferDetail",
//                        arguments: OfferScreenArgument(index, offersList));
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                'offerTitle',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                'SubCatagory',
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              '88',
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
                                          " ETB DISC",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18.0),
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
                                  child: Image(
                                    width: 90.0,
                                    image: AssetImage('assets/images/image3.jpg'),
                                    fit: BoxFit.cover,
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
          ],
        ),
    );
  }

  Future<void> fetchGeneralRewards() async {
//    CheckConnection.isConnected().then((value) async {
//      if (value) {
//    var response = await NetworkHandler.get('getAllOffers');
//
//    var decodedResponse = jsonDecode(response.body);
//    allOffers = AllOffers.fromJson(decodedResponse);
//    offersList = allOffers.allOffers;
//        saveOffers();
//      } else {
//        loadOffers();
//      }
//    });
  }

//  saveGeneralRewards() async {
//    preferences = await SharedPreferences.getInstance();
//    if(preferences.getStringList('offers')!=null)
//      preferences.remove('offers');
//    preferences.setStringList('offers',
//        offersList.map((offer) => jsonEncode(Offers.toMap(offer))).toList());
//  }
//
//  loadGeneralRewards() async {
//    preferences = await SharedPreferences.getInstance();
//
//    List<String> tempOffer = preferences.getStringList('offers');
//    offersList =
//        tempOffer.map((item) => Offers.fromJson(jsonDecode(item))).toList();
//  }
}
