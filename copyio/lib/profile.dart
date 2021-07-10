import 'dart:io';

import 'package:copyio/models/Profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _fkey = GlobalKey<FormState>();
  var _isloading = false;
  var _sampleProfile = Profiler(
    name: '',
    about: '',
    dob: null,
    email: '',
    userImage: '',
  );
  var firstRun = true;
  File _image;
  final picker = ImagePicker();

  Future _openGallery() async {
    var picture = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(picture.path);
      Provider.of<ProfileProvider>(context, listen: false).uploadImage(_image);
    });
    // Navigator.of(context).pop();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

// var _profProvider =
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (firstRun) {
      _sampleProfile = Provider.of<ProfileProvider>(context).currentProfile;
      firstRun = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.11,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                child: Container(
                  height: 400,
                  // width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50.0),
                        bottomRight: Radius.circular(50.0)),
                  ),
                  child: Stack(
                    children: [
                      _sampleProfile.userImage == null
                          ? Icon(
                              Icons.account_circle,
                              size: 100.0,
                              color: Color(0xFFD9DFFC),
                            )
                          : Image.network(
                              _sampleProfile.userImage,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                      Positioned(
                          child: IconButton(
                        onPressed: () {
                          _openGallery();
                        },
                        icon: Icon(
                          Icons.edit_rounded,
                          size: 30.0,
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              InfoCard('Name', _sampleProfile, _sampleProfile.name),
              InfoCard('About', _sampleProfile, _sampleProfile.about),
              InfoCard('Date of Birth', _sampleProfile, _sampleProfile.dob),
              InfoCard('Contact', _sampleProfile, _sampleProfile.email),
              SizedBox(height: 10.0),
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 150,
                      height: 40,
                      margin: EdgeInsets.only(right: 10.0),
                      child: _isloading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                _fkey.currentState.save();
                                setState(() {
                                  _isloading = true;
                                });
                                await Provider.of<ProfileProvider>(context,
                                        listen: false)
                                    .saveProfile(_sampleProfile);
                                setState(() {
                                  _isloading = false;
                                });
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.resolveWith(
                                    (states) => 1.0),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Color(
                                        0xFF778DF8); // Use the component's default.
                                  },
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Color(0xFFD9DFFC)),
                              )))),
              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  String txt;
  Profiler _sampleProfile;
  var iData;
  InfoCard(
    this.txt,
    this._sampleProfile,
    this.iData,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            txt,
            style: TextStyle(color: Color(0xFF446181)),
          ),
        ),
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Color(0xFFD9DFFC),
          ),
          padding: EdgeInsets.symmetric(vertical: 22.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              // width: 300,
              child: TextFormField(
                initialValue: iData == null ? '' : iData.toString(),
                enabled: txt == 'Contact' ? false : true,
                onSaved: (value) {
                  if (txt == 'Name') {
                    _sampleProfile.name = value;
                  } else if (txt == 'About') {
                    _sampleProfile.about = value;
                  } else if (txt == 'Date of Birth') {
                    _sampleProfile.dob = DateTime.now();
                  } else if (txt == 'Contact') {
                    _sampleProfile.email = value;
                  }
                },
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        )
      ],
    );
  }
}
