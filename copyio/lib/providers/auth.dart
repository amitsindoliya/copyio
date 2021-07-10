import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _refreshToken;
  Timer authTimer;

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

  String readFileSync() {
    String contents = new File('../token_data.txt').readAsStringSync();
    return contents;
  }

  Future<void> emailVerification(token) async {
    var params = {
      'key': readFileSync(),
    };
    var verifyEmail = Uri.https(
        'identitytoolkit.googleapis.com', '/v1/accounts:sendOobCode', params);

    var requestVerification = {"requestType": "VERIFY_EMAIL", "idToken": token};

    var res =
        await http.post(verifyEmail, body: jsonEncode(requestVerification));
    print(res.body);
  }

  Future<void> signUp(email, password) async {
    var params = {
      'key': readFileSync(),
    };
    var signupUri = Uri.https(
        'identitytoolkit.googleapis.com', '/v1/accounts:signUp', params);

    var requestData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    var response = await http.post(signupUri, body: jsonEncode(requestData));
    var initialToken = jsonDecode(response.body)['idToken'];
    createProfile(email, initialToken, jsonDecode(response.body)['localId']);
    // print(verificationResponse.body);
    emailVerification(initialToken);
    // print();

    notifyListeners();
  }

  Future<List> logIn(email, password) async {
    var params = {
      'key': readFileSync(),
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
    _refreshToken = reponseDecodedData['refreshToken'];
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

      return [false, reponseDecodedData['idToken']];
    }

    notifyListeners();
    _startTimer();
    var pref = await SharedPreferences.getInstance();
    var loginData = json.encode({
      'token': _token,
      'refreshToken': _refreshToken,
      'localId': _userId,
      'expiryDate': _expiryDate.toIso8601String()
    });
    pref.setString('loginData', loginData);
    return [true];
  }

  Future<void> createProfile(email, initialToken, uid) async {
    // profile.email = email;
    var params = {
      'auth': initialToken,
    };
    var data = {'email': email};
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$uid/profile.json', params);
    var response = await http.put(url, body: json.encode(data));
    print(response.body);
    notifyListeners();
  }

  Future<bool> autoLogin() async {
    var pref = await SharedPreferences.getInstance();
    // print('///")');
    // print('****' + pref.containsKey('loginData').toString());
    if (!pref.containsKey('loginData')) {
      return false;
    }

    var savedLoginData = pref.getString('loginData');
    var savedDecodedLoginData = json.decode(savedLoginData);
    _token = savedDecodedLoginData['token'];
    _expiryDate = DateTime.parse(savedDecodedLoginData['expiryDate']);
    _userId = savedDecodedLoginData['localId'];
    _refreshToken = savedDecodedLoginData['refreshToken'];

    if (_expiryDate.isBefore(DateTime.now())) {
      await getNewToken();
    } else {
      _startTimer();
    }
    notifyListeners();
    return true;
  }

  Future<void> getNewToken() async {
    var params = {
      'key': readFileSync(),
    };
    var updatedTokenUri =
        Uri.https('securetoken.googleapis.com', '/v1/token', params);

    var requestData = {
      'grant_type': 'refresh_token',
      'refresh_token': _refreshToken,
    };

    var updatedResponse = await http.post(
      updatedTokenUri,
      body: jsonEncode(requestData),
    );
    var updatedDecodedResponse = json.decode(updatedResponse.body);
    _token = updatedDecodedResponse['id_token'];
    _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(updatedDecodedResponse['expires_in'])));
    _userId = updatedDecodedResponse['user_id'];
    _refreshToken = updatedDecodedResponse['refresh_token'];
    // notifyListeners();
    _startTimer();
  }

  void logout() async {
    _expiryDate = null;
    _token = null;
    _userId = null;
    authTimer = null;
    var pref = await SharedPreferences.getInstance();
    pref.remove('loginData');
    notifyListeners();
  }

  void _startTimer() {
    // print('timer in');
    if (authTimer != null) {
      authTimer.cancel();
    }
    var timerTime = _expiryDate.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timerTime), () async {
      // print('timer out');
      await getNewToken();

      notifyListeners();
    });
  }
}
