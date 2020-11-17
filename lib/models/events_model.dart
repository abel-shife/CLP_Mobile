import 'dart:convert';

class AllEvents {
  List<Events> allEvents;

  AllEvents({this.allEvents});

  AllEvents.fromJson(Map<String, dynamic> json) {
    if (json['allEvents'] != null) {
      allEvents = new List<Events>();
      json['allEvents'].forEach((v) {
        allEvents.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allEvents != null) {
      data['Events'] = this.allEvents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String sId;
  String eventTitle;
  String eventDescription;
  String eventImage;
  String eventDate;
  String eventStartTime;
  String selectedLevel;
  int numberOfPeople;
  String eventBranch;
  int like;
  int dislike;
  int share;
  int iV;

 Events(
      {this.sId,
        this.eventTitle,
        this.eventDescription,
        this.eventImage,
        this.eventDate,
        this.eventStartTime,
        this.selectedLevel,
        this.numberOfPeople,
        this.eventBranch,
        this.like,
        this.dislike,
        this.share,
        this.iV});

  Events.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventTitle = json['eventTitle'];
    eventDescription = json['eventDescription'];
    eventImage = json['eventImage'];
    eventDate = json['eventDate'];
    eventStartTime = json['eventStartTime'];
    selectedLevel = json['selectedLevel'];
    numberOfPeople = json['numberOfPeople'];
    eventBranch = json['eventBranch'];
    like = json['like'];
    dislike = json['dislike'];
    share = json['share'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['eventTitle'] = this.eventTitle;
    data['eventDescription'] = this.eventDescription;
    data['eventImage'] = this.eventImage;
    data['eventDate'] = this.eventDate;
    data['eventStartTime'] = this.eventStartTime;
    data['selectedLevel'] = this.selectedLevel;
    data['numberOfPeople'] = this.numberOfPeople;
    data['eventBranch'] = this.eventBranch;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['share'] = this.share;
    data['__v'] = this.iV;
    return data;
  }

  static Map<String, dynamic> toMap(Events event) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = event.sId;
    data['eventTitle'] = event.eventTitle;
    data['eventDescription'] = event.eventDescription;
    data['eventImage'] = event.eventImage;
    data['eventDate'] = event.eventDate;
    data['eventStartTime'] = event.eventStartTime;
    data['selectedLevel'] = event.selectedLevel;
    data['numberOfPeople'] = event.numberOfPeople;
    data['eventBranch'] = event.eventBranch;
    data['like'] = event.like;
    data['dislike'] = event.dislike;
    data['share'] = event.share;
    data['__v'] = event.iV;
    return data;
  }

}
