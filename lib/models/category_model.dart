class AllCatagories {
  List<Catagories> allCatagories;

  AllCatagories({this.allCatagories});

  AllCatagories.fromJson(Map<String, dynamic> json) {
    if (json['allCatagories'] != null) {
      allCatagories = new List<Catagories>();
      json['allCatagories'].forEach((v) {
        allCatagories.add(new Catagories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allCatagories != null) {
      data['allCatagories'] =
          this.allCatagories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Catagories {
  String sId;
  List<SubCatagory> subCatagory;
  String catagoryName;
  int iV;

  Catagories({this.sId, this.subCatagory, this.catagoryName, this.iV});

  Catagories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['subCatagory'] != null) {
      subCatagory = new List<SubCatagory>();
      json['subCatagory'].forEach((v) {
        subCatagory.add(new SubCatagory.fromJson(v));
      });
    }
    catagoryName = json['catagoryName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.subCatagory != null) {
      data['subCatagory'] = this.subCatagory.map((v) => v.toJson()).toList();
    }
    data['catagoryName'] = this.catagoryName;
    data['__v'] = this.iV;
    return data;
  }
}

class SubCatagory {
  String sId;
  String subCatagoryName;

  SubCatagory({this.sId, this.subCatagoryName});

  SubCatagory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subCatagoryName = json['subCatagoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['subCatagoryName'] = this.subCatagoryName;
    return data;
  }
}
