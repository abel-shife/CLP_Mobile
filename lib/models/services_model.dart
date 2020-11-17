
class AllServices {
  List<Services> allServices;

  AllServices({this.allServices});

  AllServices.fromJson(Map<String, dynamic> json) {
    if (json['allServices'] != null) {
      allServices = new List<Services>();
      json['allServices'].forEach((v) {
        allServices.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allServices != null) {
      data['Services'] = this.allServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String sId;
  String selectedServiceCatagory;
  String selectedServiceSubCatagory;
  String serviceName;
  num servicePrice;
  String serviceDescription;
  String serviceImage;
  int iV;

  Services(
      {this.sId,
      this.selectedServiceCatagory,
      this.selectedServiceSubCatagory,
      this.serviceName,
      this.servicePrice,
      this.serviceDescription,
      this.serviceImage,
      this.iV});

  factory Services.fromJson(Map<dynamic, dynamic> json) {
    return Services(
      sId: json['_id'],
      selectedServiceCatagory: json['selectedServiceCatagory'],
      selectedServiceSubCatagory: json['selectedServiceSubCatagory'],
      serviceName: json['serviceName'],
      servicePrice: json['servicePrice'],
      serviceDescription: json['serviceDescription'],
      serviceImage: json['serviceImage'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['selectedServiceCatagory'] = this.selectedServiceCatagory;
    data['selectedServiceSubCatagory'] = this.selectedServiceSubCatagory;
    data['serviceName'] = this.serviceName;
    data['servicePrice'] = this.servicePrice;
    data['serviceDescription'] = this.serviceDescription;
    data['serviceImage'] = this.serviceImage;
    data['__v'] = this.iV;
    return data;
  }

  static Map<String, dynamic> toMap(Services services) {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = services.sId;
    data['selectedServiceCatagory'] = services.selectedServiceCatagory;
    data['selectedServiceSubCatagory'] = services.selectedServiceSubCatagory;
    data['serviceName'] = services.serviceName;
    data['servicePrice'] = services.servicePrice;
    data['serviceDescription'] = services.serviceDescription;
    data['serviceImage'] = services.serviceImage;
    data['__v'] = services.iV;
    return data;

  }

}
