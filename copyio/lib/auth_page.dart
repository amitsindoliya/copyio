import 'package:copyio/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Page {
  Login,
  SignUp,
}

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _formkey = GlobalKey<FormState>();
  var _currPage;
  var _emailController = new TextEditingController();
  var _retypepasswordController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var _authData = {
    'email': '',
    'password': '',
  };
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _currPage = Page.Login;
    super.initState();
  }

  Future<void> _saveForm() async {
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_currPage == Page.Login) {
      var verifiedUser = await Provider.of<Auth>(context, listen: false).logIn(
        _authData['email'],
        _authData['password'],
      );
      if (verifiedUser == false) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  // title: Text('Please verify your email'),
                  content: Container(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.close),
                        Text(
                          "OOPS!! Unverified Email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.asset("assets/images/email-133-128 (1).png"),
                        Text(
                          "please verify your email using the link in your mail",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Resend')),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      }
    } else {
      // print(_authData);
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['email'],
        _authData['password'],
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  // TextEditingController();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xFF787FF6),
      Color(0xFF4ADEDE),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: TopClipPath(),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFF787FF6),
                    Color(0xFF4ADEDE),
                  ])),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                        child: ClipPath(
                      clipper: MidCustomClipPath(),
                      child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color(0xFF787FF6),
                          Color(0xFF4ADEDE),
                        ])),
                      ),
                    )),
                    Form(
                      // autovalidateMode: AutovalidateMode.always,
                      key: _formkey,
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _currPage == Page.Login
                                  ? 'Welcome to Notescove'
                                  : 'Join Us!',
                              style: TextStyle(
                                fontSize: 30.0,
                                // color: Theme.of(context).primaryColor,
                                foreground: Paint()..shader = linearGradient,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            _currPage == Page.Login
                                ? Text(
                                    'Open your book',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      // color: Theme.of(context).primaryColor,
                                      foreground: Paint()
                                        ..shader = linearGradient,
                                      fontWeight: FontWeight.w300,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : SizedBox(),
                            Text(
                              _currPage == Page.Login
                                  ? 'please login to continue'
                                  : 'please fill the details to continue',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: Colors.black,
                              ),
                              child: TextFormField(
                                // initialValue: '',
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                                controller: _emailController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email_rounded),
                                  focusedBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                validator: (value) {
                                  if (!value.contains('@')) {
                                    return 'Invalid email!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: Colors.black,
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  _authData['password'] = value;
                                },
                                // initialValue: '',
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  focusedBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  suffixIcon: Icon(Icons.lock_rounded),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            if (_currPage == Page.SignUp)
                              SizedBox(
                                height: 10,
                              ),
                            if (_currPage == Page.SignUp)
                              Theme(
                                data: Theme.of(context).copyWith(
                                  primaryColor: Colors.black,
                                ),
                                child: TextFormField(
                                  // initialValue: '',
                                  controller: _retypepasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: new UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    suffixIcon: Icon(Icons.lock_rounded),
                                    hintText: 'Retype Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (value) {
                                    if (value != _passwordController.text) {
                                      return 'Password does not match';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    _currPage == Page.Login
                                        ? 'Forgot your Password?'
                                        : 'I accept the policy and terms',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(11),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // primary: Theme.of(context).primaryColor,
                                          padding: const EdgeInsets.all(0.0),
                                        ),
                                        onPressed: _saveForm,
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF787FF6),
                                              Color(0xFF4ADEDE),
                                            ]),
                                          ),
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Text(
                                              _currPage == Page.Login
                                                  ? 'Sign In'
                                                  : 'Register',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_currPage == Page.Login) {
                                        _currPage = Page.SignUp;
                                      } else {
                                        _currPage = Page.Login;
                                      }
                                    });
                                  },
                                  child: Container(
                                      decoration: _currPage == Page.Login
                                          ? BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .primaryColor)))
                                          : BoxDecoration(),
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w300,
                                            color: _currPage == Page.Login
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_currPage == Page.Login) {
                                        _currPage = Page.SignUp;
                                      } else {
                                        _currPage = Page.Login;
                                      }
                                    });
                                  },
                                  child: Container(
                                      decoration: _currPage != Page.Login
                                          ? BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .primaryColor)))
                                          : BoxDecoration(),
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w300,
                                            color: _currPage != Page.Login
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey),
                                      )),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MidCustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    print(size.height);
    path.moveTo(size.width, 0);
    path.lineTo(size.width / 2, size.height / 1.8);
    // path.quadraticBezierTo(50, 100, 250, 300);
    path.lineTo(size.width, size.height + 80);
    // path.arcToPoint(Offset(400, 100), radius: Radius.circular(15));
    // throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
    // throw UnimplementedError();
  }
}

class TopClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    print(size.height);
    path.lineTo(0, size.height);
    path.lineTo(75, 50);
    // path.arcToPoint(Offset(400, 100), radius: Radius.circular(15));
    // throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
    // throw UnimplementedError();
  }
}
