import 'dart:convert';

import 'package:async/async.dart';
import 'package:finalloyal/AppServices/Debouncer.dart';
import 'package:finalloyal/AppServices/NetworkHandler.dart';
import 'package:finalloyal/animations/Shimmers.dart';
import 'package:finalloyal/models/category_model.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/models/services_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:finalloyal/widgets/ServicesListBuilder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Service extends StatefulWidget {

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {

  SharedPreferences preferences;
  AllServices allServices;
  List<Services> servicesList;
  List<String> subCategories;
  AllCatagories allCatagories;
  List<Catagories> catagoryList;
  final AsyncMemoizer memoizer = AsyncMemoizer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCatagory(),
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
              return networkErrorShimmerBuilder();
            else
              return categoryBuilder();
            break;
        }
        return null;
      },
    );
  }

  RefreshIndicator categoryBuilder() {
    return RefreshIndicator(
      onRefresh: fetchCatagory,
      child:  catagoryList!=null? Column(
        children: <Widget>[
          SizedBox(height: 10.0,),
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 16.0),
//            child: Container(
//              decoration: getElevationProperty(),
//              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
//              child: Text('Slide Down to refresh')
//            ),
//          ),
          Expanded(
              child: Scrollbar(
                child: ListView.builder(
            itemCount:catagoryList.length,
            itemBuilder: (context, index) {
                return ExpansionTile(
                  title: serviceItemsBuilder(
                      'assets/images/image1.jpg', catagoryList[index].catagoryName.toUpperCase()),
                  children: [
                     FutureBuilder(
                            future: fetchService(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return networkErrorShimmerBuilder();
                                  break;
                                case ConnectionState.active:
                                  break;
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  );
                                  break;
                                case ConnectionState.done:
                                  if (snapshot.hasError)
                                    return networkErrorShimmerBuilder();
                                  else
                                    return ServicesListBuilder(
                                       servicesList,
                                       subCategories,
                                       catagoryList[index].catagoryName);
                                  break;
                              }
                              return null;
                            },
                          ),
                  ],
                );
            },
          ),
              )),
//        SizedBox(
//          height: 20.0,
//        ),
//        ExpansionTile(
//          title: serviceItemsBuilder('assets/images/image2.jpg', 'DRINKS'),
//          children: [
//            servicesList == null
//                ? Center(
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: CircularProgressIndicator(
//                        backgroundColor: Theme.of(context).primaryColorLight,
//                      ),
//                    ),
//                  )
//                : ServicesListBuilder(
//                    allServices, servicesList, subCategories, 'Drink'),
//          ],
//        ),
//        SizedBox(
//          height: 20.0,
//        ),
//        ExpansionTile(
//          title: serviceItemsBuilder('assets/images/image3.jpg', 'BED'),
//          children: [
//            servicesList == null
//                ? Center(
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: CircularProgressIndicator(
//                        backgroundColor: Theme.of(context).primaryColorLight,
//                      ),
//                    ),
//                  )
//                : ServicesListBuilder(
//                    allServices, servicesList, subCategories, 'Bed'),
//          ],
//        ),
//        SizedBox(
//          height: 20.0,
//        ),
        ],
      ):
      Center(
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
                    Text('events available', style: TextStyle(fontSize: 18.0),),
                    Icon(Icons.arrow_forward_ios,size: 30.0,),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Padding serviceItemsBuilder(String imgPath, String categoryName) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 75.0,
            width: 75.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150.0),
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            categoryName,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 17.0),
          )
        ],
      ),
    );
  }

  Future<void> fetchService() async{
//    CheckConnection.isConnected().then((value) async {
//      if (value) {
//    return this.memoizer.runOnce(() async {
      var response = await NetworkHandler.get('getAllServices');

      var decodedResponse = jsonDecode(response.body);
      allServices = AllServices.fromJson(decodedResponse);
      servicesList =allServices.allServices;
//    });

//    saveServices();
//      } else {
//        loadServices();
//      }
//    });
  }

  Future<void> fetchCatagory()  {
//    CheckConnection.isConnected().then((value) async {
//      if (value) {

    return this.memoizer.runOnce(() async {
      var response = await NetworkHandler.get('getAllCatagory');

      var decodedResponse = jsonDecode(response.body);
      allCatagories = AllCatagories.fromJson(decodedResponse);
      catagoryList = allCatagories.allCatagories;
    });

//    debugPrint()
//      } else {
//        loadServices();
//      }
//    });
  }

  saveServices() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList('services') != null)
      preferences.remove('services');
    preferences.setStringList(
        'services',
       servicesList
            .map((offer) => jsonEncode(Services.toMap(offer)))
            .toList());
  }

  loadServices() async {
    preferences = await SharedPreferences.getInstance();
    List<String> tempOffer = preferences.getStringList('services');
    servicesList =
        tempOffer.map((item) => Services.fromJson(jsonDecode(item))).toList();
  }
}
