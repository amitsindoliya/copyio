import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool isAuth() {
    return token() != null;
  }

  String get userId {
    if (token() != null) {
      return _userId;
    }
    return null;
  }

  String token() {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signUp(email, password) async {
    const params = {
      'key': 'AIzaSyC8rAgo-DmI86l5AsaqC6zZGcLtilKLOJo',
    };
    var signupUri = Uri.https(
        'identitytoolkit.googleapis.com', '/v1/accounts:signUp', params);
    var verifyEmail = Uri.https(
        'identitytoolkit.googleapis.com', '/v1/accounts:sendOobCode', params);

    var requestData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    var response = await http.post(signupUri, body: jsonEncode(requestData));
    var requestVerification = {
      "requestType": "VERIFY_EMAIL",
      "idToken": jsonDecode(response.body)['idToken']
    };

    var verificationResponse =
        await http.post(verifyEmail, body: jsonEncode(requestVerification));
    print(verificationResponse.body);

    // print();

    notifyListeners();
  }

  Future<bool> logIn(email, password) async {
    const params = {
      'key': 'AIzaSyC8rAgo-DmI86l5AsaqC6zZGcLtilKLOJo',
    };
    var loginURI = Uri.https('identitytoolkit.googleapis.com',
        '/v1/accounts:signInWithPassword', params);
    var requestData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    var response = await http.post(loginURI, body: jsonEncode(requestData));
    var reponseDecodedData = jsonDecode(response.body);
    _token = reponseDecodedData['idToken'];
    _expiryDate = DateTime.now()
        .add(Duration(seconds: int.parse(reponseDecodedData['expiresIn'])));
    _userId = reponseDecodedData['localId'];
    // print(_token);
    var confirmEmail = Uri.https(
        'identitytoolkit.googleapis.com', '/v1/accounts:lookup', params);
    var confirmVerification = {"idToken": _token};

    var confirmEmailResponse = await http.post(
      confirmEmail,
      body: jsonEncode(confirmVerification),
    );
    var emailVerified =
        jsonDecode(confirmEmailResponse.body)['users'][0]['emailVerified'];
    if (emailVerified == false) {
      logout();
      return false;
    }

    notifyListeners();
    return true;
  }

  void logout() {
    _expiryDate = null;
    _token = null;
    _userId = null;
    notifyListeners();
  }
}
