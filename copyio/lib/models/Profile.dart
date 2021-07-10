import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Profiler {
  String name;
  String about;
  DateTime dob;
  String email;
  String userImage;

  Profiler({
    this.name,
    this.about,
    this.dob,
    this.email,
    this.userImage,
  });
}

class ProfileProvider with ChangeNotifier {
  Profiler profile = Profiler(
    name: '',
    about: '',
    email: '',
    dob: null,
    userImage: '',
  );
  String authToken;
  String authuserId;
  void update(String token, String userId) {
    authToken = token;
    authuserId = userId;
  }

  Profiler get currentProfile {
    return Profiler(
      name: profile.name,
      about: profile.about,
      dob: profile.dob,
      email: profile.email,
      userImage: profile.userImage,
    );
  }

  void getProfileFromServer() async {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/profile.json', params);
    var response = await http.get(url);
    var decodedProfile = jsonDecode(response.body);
    profile.name = decodedProfile['name'];
    profile.dob = DateTime.parse(decodedProfile['dob']);
    profile.about = decodedProfile['about'];
    profile.email = decodedProfile['email'];
    profile.userImage = decodedProfile['userImage'];
    notifyListeners();
  }

  Future<void> saveProfile(prof) async {
    profile = prof;
    var params = {
      'auth': authToken,
    };
    var data = {
      'name': profile.name,
      'about': profile.about,
      'dob': profile.dob.toIso8601String(),
      'email': profile.email,
      'userImage': profile.userImage,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/profile.json', params);
    var response = await http.patch(url, body: json.encode(data));
    notifyListeners();
  }

  String readFileSync() {
    String contents = new File('../token_data.txt').readAsStringSync();
    return contents;
  }

  Future<void> uploadImage(file) async {
    var params = {
      'key': readFileSync(),
      'uploadType': 'media',
      'name': 'authuserId.png'
    };
    // var bucketName = 'notescove-6c068.appspot.com';
    // var headers = {"Content-Type": "image/png"};
    // var uploaduri = Uri.https(
    //     'storage.googleapis.com', '/upload/storage/v1/b/$bucketName/o');
    var accessToken = 'b94fc661-40d6-4da1-af13-919287d49ff3';

    File image = file;
    var imageName = '$authuserId.png';
    var request = Request(
      'POST',
      Uri.parse(
          'https://www.googleapis.com/upload/storage/v1/b/storage.googleapis.com/o?uploadType=media&name=images/$imageName'),
    );
    request.headers['Authorization'] = "Bearer $accessToken";
    request.headers['Content-Type'] = "image/png";
    request.bodyBytes = await image.readAsBytes();

    Response response = await Response.fromStream(await request.send());
    print(response.body);
    notifyListeners();
    // "uploadType=media&name=OBJECT_NAME";
    // http.post(uploaduri, headers: headers);
  }
}
