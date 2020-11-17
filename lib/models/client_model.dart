class Client {
  String sId;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  String birthDate;
  bool isFemale;
  int iV;




  Client(
      {this.sId,this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.password,
      this.birthDate,
      this.isFemale,
      this.iV});

  factory Client.fromJson(Map<dynamic, dynamic> json) {
    return Client(
      sId: json['sId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      birthDate: json['birthDate'],
      isFemale: json['gender'],
      iV: json['iV'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sId':this.sId,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phoneNumber': this.phoneNumber,
      'email': this.email,
      'password': this.password,
      'birthDate': this.birthDate,
      'isFemale': this.isFemale,
      'iV':this.iV
    };
  }
}
