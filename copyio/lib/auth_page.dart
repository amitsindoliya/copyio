import 'package:flutter/material.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    _currPage = Page.Login;
    super.initState();
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
                    Container(
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
                          TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'E-mail',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: new UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                          if (_currPage == Page.SignUp)
                            SizedBox(
                              height: 10,
                            ),
                          if (_currPage == Page.SignUp)
                            TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
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
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // primary: Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.all(0.0),
                                ),
                                onPressed: () {},
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
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
                            height: 60,
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (_currPage == Page.Login) {
                                      _currPage = Page.SignUp;
                                    } else {
                                      _currPage = Page.Login;
                                    }
                                  });
                                  // Page.SignUp;
                                },
                                child: Text(
                                  _currPage == Page.Login
                                      ? 'New to Notescove? Sign Up instead'
                                      : 'Already have account? Login',
                                  // style: TextStyle(fontSize: 18.0),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                        ],
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
