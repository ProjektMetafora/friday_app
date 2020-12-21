import 'dart:convert';

import 'package:friday_app/constants/backend.url.dart';
import 'package:friday_app/models/user_model.dart';
import 'package:requests/requests.dart';

class LoginService {
  LoginService._internal();

  static final LoginService _instance = LoginService._internal();

  static LoginService get instance => _instance;

  FridayUser _currentUser;

  FridayUser get currentUser => _currentUser;

  FridayUser _setCurrentUser(FridayUser currentUser) {
    if (currentUser != null) {
      _currentUser = currentUser;
    }

    return _currentUser;
  }

  Future<FridayUser> registerUser(FridayRegisterUser user) async {
    // encode to base64 username:password
    String encoded = base64.encode(utf8.encode("${user.email}:${user.password}"));

    try {
      var r = await Requests.post(
        '$baseUrl/register/$encoded',
        body: user.toJSONContract(),
        bodyEncoding: RequestBodyEncoding.JSON,
      );
      r.raiseForStatus();
      String response = r.content();
      print(response);

      return null;
    } catch (err) {
      return null;
    }
  }

  Future<FridayUser> loginUser(String email, String password) async {

    // encode to base64 username:password
    String encoded = base64.encode(utf8.encode("$email:$password"));

    return _setCurrentUser(FridayUser());

    try {
      var r = await Requests.get(
        '$baseUrl/login/$encoded',
        bodyEncoding: RequestBodyEncoding.JSON,
      );
      r.raiseForStatus();

      Map<String, dynamic> response = r.json();

      return _setCurrentUser(FridayUser());

    } catch (err) {
      return null;
    }

  }
}
