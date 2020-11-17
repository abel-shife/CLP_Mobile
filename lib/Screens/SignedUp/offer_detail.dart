import 'dart:convert';

import 'package:finalloyal/Screens/SignedUp/offer.dart';
import 'package:finalloyal/animations/FadeAnimation.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/models/offers_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferDetail extends StatefulWidget {
  final int position;
  final List<Offers> offersList;

  OfferDetail(this.position, this.offersList);

  @override
  _OfferDetailState createState() => _OfferDetailState();
}

class _OfferDetailState extends State<OfferDetail> {
  var selectedCard;
  AutoScrollController scrollController;
  bool liked = false,
      disliked = false;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();

    scrollController.scrollToIndex(widget.position,
        duration: Duration(seconds: 2));
    selectedCard = widget.offersList[widget.position].serviceName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 200,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.0)),
                ),
                child: Hero(
                  tag: widget.position,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/image1.jpg'),
                            fit: BoxFit.cover,
                          )),
                      child: Container(
                        decoration: BoxDecoration(gradient: getImageGradient()),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FadeAnimation(
                      0.5,
                      Text(
                        widget.offersList[widget.position].offerTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
//                    Row(
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(Icons.search),
//                          iconSize: 30.0,
//                          color: Colors.black,
//                          onPressed: () {},
//                        ),
//                        IconButton(
//                          icon: Icon(Icons.sort),
//                          iconSize: 30.0,
//                          color: Colors.black,
//                          onPressed: () {},
//                        ),
//                      ],
//                    )
                  ],
                ),
              ),
              Positioned(
                left: 15.0,
                top: 90.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        widget.offersList[widget.position].offerTitle +
                            ":  for " +
                            widget.offersList[widget.position].selectedLevel +
                            " levels",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Colors.white70,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                '\$ ' +
                                    widget.offersList[widget.position]
                                        .servicePrice
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white70,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                ' - ' +
                                    widget.offersList[widget.position]
                                        .discountPercent
                                        .toString() +
                                    " % ",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25.0,
                            color: Colors.white70,
                            width: 1.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.white70,
                          ),
                          Text(
                            '\$ ' +
                                (widget.offersList[widget.position]
                                    .servicePrice -
                                    widget.offersList[widget.position]
                                        .discountPrice)
                                    .toString(),
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white70,
                                decoration: TextDecoration.underline),
                          ),
//                        Container(
//                          width: 125.0,
//                          height: 40.0,
//                          decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(17.0),
//                              color: Color(0xFF7A9BEE)),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            children: <Widget>[
//                              InkWell(
//                                onTap: () {},
//                                child: Container(
//                                  height: 25.0,
//                                  width: 25.0,
//                                  decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.circular(7.0),
//                                    color: Color(0xFF7A9BEE),
//                                  ),
//                                  child: Center(
//                                    child: Icon(
//                                      Icons.remove,
//                                      color: Colors.white,
//                                      size: 20.0,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Text(
//                                '2',
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 15.0),
//                              ),
//                              InkWell(
//                                onTap: () {},
//                                child: Container(
//                                  height: 25.0,
//                                  width: 25.0,
//                                  decoration: BoxDecoration(
//                                    borderRadius: BorderRadius.circular(7.0),
//                                    color: Colors.white,
//                                  ),
//                                  child: Center(
//                                    child: Icon(
//                                      Icons.add,
//                                      color: Color(0xFF7A9BEE),
//                                      size: 20.0,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        height: 150.0,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            infoCardBuilder(
                                widget.offersList[widget.position].serviceName,
                                widget.offersList[widget.position]
                                    .selectedServiceCatagory,
                                widget.offersList[widget.position]
                                    .selectedServiceSubCatagory,
                                false),
                            SizedBox(
                              width: 10.0,
                            ),
                            infoCardBuilder(
                                widget.offersList[widget.position].startDate
                                    .substring(0, 10),
                                widget.offersList[widget.position].endDate
                                    .substring(0, 10),
                                widget
                                    .offersList[widget.position].numberOfPeople
                                    .toString(),
                                true),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
//                    Padding(
//                      padding: EdgeInsets.only(bottom: 5.0),
//                      child: Container(
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.only(
//                              bottomLeft: Radius.circular(10.0),
//                              bottomRight: Radius.circular(10.0),
//                            ),
//                            color: Colors.black),
//                        height: 50.0,
//                        child: Center(
//                          child: Text(
//                            '\$52.00 total',
//                            style: TextStyle(
//                              color: Colors.white,
//                            ),
//                          ),
//                        ),
//                      ),
//                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 5.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(0.0),
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              alignment: Alignment.bottomCenter,
                              icon: Icon(FontAwesomeIcons.solidThumbsDown),
                              onPressed: () async{
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                Client client;

                                  client = Client.fromJson(jsonDecode(preferences.getString('client')));
                                setState(() {
                                  if(liked){
                                    widget.offersList[widget.position].like--;
                                    likeOffer(client.sId,false);
                                  }else{
                                    dislikeOffer(client.sId,false);
                                  }
                                  dislikeOffer(client.sId,true);
                                });
                              },
                            ),
                            Text(
                              widget.offersList[widget.position].dislike
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                  color: Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(0.0),
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              alignment: Alignment.bottomCenter,
                              icon: Icon(FontAwesomeIcons.solidThumbsUp),
                              onPressed: () {
                                setState(() {
                                  widget.offersList[widget.position].like++;
                                });
                              },
                            ),
                            Text(
                              widget.offersList[widget.position].like
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0,
                                  color: Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                            SizedBox(width: 20.0),
                            IconButton(
                              padding: EdgeInsets.all(0.0),
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              alignment: Alignment.bottomCenter,
                              icon: Icon(FontAwesomeIcons.share),
                              onPressed: () {
                                shareOffer(widget.offersList[widget.position]);
                              },
                            ),
                            SizedBox(
                              width: 16.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: widget.offersList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/OfferDetail",
                          arguments:
                          OfferScreenArgument(index, widget.offersList));
                    },
                    child: AutoScrollTag(
                      key: ValueKey(index),
                      controller: scrollController,
                      index: index,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                              height: 170.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .accentColor,
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
                                                widget.offersList[index]
                                                    .offerTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                widget.offersList[index]
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
                                              calculateLeftDays(widget
                                                  .offersList[index].startDate),
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
                                          widget.offersList[index]
                                              .discountPercent
                                              .round()
                                              .toString() +
                                              " % , " +
                                              widget.offersList[index]
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  width: 90.0,
                                  image: AssetImage('assets/images/image3.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget infoCardBuilder(String firstString, String secondString,
      String thirdString, bool isDate) {
    return InkWell(
      onTap: () {
        selectCard(firstString);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: firstString == selectedCard
                ? Theme
                .of(context)
                .primaryColorDark
                : Colors.white,
            border: Border.all(
                color: firstString == selectedCard
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.3),
                style: BorderStyle.solid,
                width: 0.75)),
        height: 100.0,
        width: firstString == selectedCard
            ? MediaQuery
            .of(context)
            .size
            .width * 0.6
            : MediaQuery
            .of(context)
            .size
            .width * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  isDate
                      ? Icon(Icons.event_available)
                      : Icon(Icons.restaurant_menu),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      firstString,
                      style: TextStyle(
                        fontSize: 22.0,
                        color: firstString == selectedCard
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  isDate ? Icon(Icons.event_busy) : Icon(Icons.fastfood),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      secondString,
                      style: TextStyle(
                          fontSize: 22.0,
                          color: firstString == selectedCard
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  isDate ? Icon(Icons.people) : Icon(Icons.local_cafe),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      thirdString,
                      style: TextStyle(
                          fontSize: 22.0,
                          color: firstString == selectedCard
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              firstString != selectedCard
                  ? Text('touch to expand',
                  style: TextStyle(fontSize: 12.0, color: Colors.black))
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  selectCard(String cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  String calculateLeftDays(String offerStartingDate) {
    return new DateTime.now()
        .difference(DateTime.parse(offerStartingDate))
        .inDays
        .toString();
  }

  void shareOffer(Offers offer) {
    final RenderBox box = context.findRenderObject();
    Share.share(
        'The Hotel has a great offer named ${offer.offerTitle} on ${offer
            .serviceName} '
            'with old price ${offer.servicePrice} in ${offer
            .discountPercent}% discount and the new price is ${offer
            .discountPrice},'
            'starting from ${offer.startDate.substring(0, 10)} up to ${offer
            .endDate.substring(0, 10)}. Check it out ',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

void dislikeOffer(String sId, bool dislike) {
}

void likeOffer(String sId, bool like) {
}
