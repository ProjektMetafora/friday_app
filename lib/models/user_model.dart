import 'package:flutter/cupertino.dart';

class FridayUser {
  String name;
}

class FridayRegisterUser {
  String email;
  String password;
  String firstName;
  String lastName;
  String countryCode;
  String mob;

  FridayRegisterUser(
      {@required this.email,
      @required this.password,
      @required this.firstName,
      @required this.lastName,
      @required this.countryCode,
      @required this.mob});

  Map<String, dynamic> toJSONContract() {
    return <String, dynamic>{
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "country_code": countryCode,
      "mob": mob,
    };
  }
}
