class AllOffers {
  List<Offers> allOffers;

  AllOffers({this.allOffers});

  AllOffers.fromJson(Map<String, dynamic> json) {
    if (json['allOffers'] != null) {
      allOffers = new List<Offers>();
      json['allOffers'].forEach((v) {
        allOffers.add(new Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allOffers != null) {
      data['Offers'] = this.allOffers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Offers {
  String sId;
  String offerTitle;
  String serviceName;
  num servicePrice;
  String selectedLevel;
  String selectedServiceCatagory;
  String selectedServiceSubCatagory;
  String serviceImage;
  num discountPercent;
  num discountPrice;
  int numberOfPeople;
  String startDate;
  String endDate;
  int like;
  int dislike;
  int share;
  int iV;

  Offers(
      {this.sId,
        this.offerTitle,
        this.serviceName,
        this.servicePrice,
        this.selectedLevel,
        this.selectedServiceCatagory,
        this.selectedServiceSubCatagory,
        this.serviceImage,
        this.discountPercent,
        this.discountPrice,
        this.numberOfPeople,
        this.startDate,
        this.endDate,
        this.like,
        this.dislike,
        this.share,
        this.iV});

  Offers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    offerTitle = json['offerTitle'];
    serviceName = json['serviceName'];
    servicePrice = json['servicePrice'];
    selectedLevel = json['selectedLevel'];
    selectedServiceCatagory = json['selectedServiceCatagory'];
    selectedServiceSubCatagory = json['selectedServiceSubCatagory'];
    serviceImage = json['serviceImage'];
    discountPercent = json['discountPercent'];
    discountPrice = json['discountPrice'];
    numberOfPeople = json['numberOfPeople'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    like = json['like'];
    dislike = json['dislike'];
    share = json['share'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['offerTitle'] = this.offerTitle;
    data['serviceName'] = this.serviceName;
    data['servicePrice'] = this.servicePrice;
    data['selectedLevel'] = this.selectedLevel;
    data['selectedServiceCatagory'] = this.selectedServiceCatagory;
    data['selectedServiceSubCatagory'] = this.selectedServiceSubCatagory;
    data['serviceImage'] = this.serviceImage;
    data['discountPercent'] = this.discountPercent;
    data['discountPrice'] = this.discountPrice;
    data['numberOfPeople'] = this.numberOfPeople;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['share'] = this.share;
    data['__v'] = this.iV;
    return data;
  }

  static Map<String, dynamic> toMap(Offers offer) {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = offer.sId;
    data['selectedServiceName'] = offer.serviceName;
    data['selectedServiceSubCatagory'] = offer.selectedServiceSubCatagory;
    data['selectedServiceCatagory'] = offer.selectedServiceCatagory;
    data['servicePrice'] = offer.servicePrice;
    data['offerTitle'] = offer.offerTitle;
    data['startDate'] = offer.startDate;
    data['endDate'] = offer.endDate;
    data['selectedLevel'] = offer.selectedLevel;
    data['discountPrice'] = offer.discountPrice;
    data['discountPercent'] = offer.discountPercent;
    data['numberofPeople'] = offer.numberOfPeople;
    data['__v'] = offer.iV;
    return data;

  }

}
