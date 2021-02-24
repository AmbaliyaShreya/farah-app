import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_app/controllers/login_controller.dart';
import 'package:my_app/views/login_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends StateMVC<SignupScreen> {
  Controller _loginController;
  _SignupScreenState():super(Controller()){
    this._loginController=controller;
  }
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'phone': '',
    'password': '',
    'confirmPassword': '',
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String msg = '';
  bool rememberCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phoneCntrl = TextEditingController();
    final _passwordCntrl = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage("assets/images/Login1.png"),
          //       fit: BoxFit.cover),
          // ),
          child: Image.asset(
            "assets/images/Login1.png",
            fit: BoxFit.fill,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 120, 40, 0),
          child: Container(
              width: size.width,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/Group 649.png",
                    fit: BoxFit.fill,
                  ),
                ],
              )),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(8, 260, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 35),
                    child: Text('Signup',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 28,
                            letterSpacing: 1))),
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      // color: Colors.black38,
                      child: Image.asset(
                        "assets/images/Union5.png",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: size.height,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 35,
                      right: 35,
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                      constraints:
                                          BoxConstraints(maxHeight: 500),
                                      child: SingleChildScrollView(
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[

                                            Text(msg,
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 20)),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: 'Email'),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Email number is required!';
                                                }
                                                return null;
                                              },
                                              onSaved: (String value) {
                                                print("desc");
                                                // _loginController.phone=value;
                                                _authData['email'] = value;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: 'Name'),
                                              keyboardType: TextInputType.name,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Name is required!';
                                                }
                                                return null;
                                              },
                                              onSaved: (String value) {
                                                print("desc");
                                                // _loginController.phone=value;
                                                _authData['name'] = value;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: 'Phone'),
                                              keyboardType: TextInputType.phone,
                                              controller: _phoneCntrl,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Phone number is required!';
                                                }
                                                return null;
                                              },
                                              onSaved: (String value) {
                                                print("desc");
                                                // _loginController.phone=value;
                                                _authData['phone'] = value;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: 'Password'),
                                              obscureText: true,
                                              controller: _passwordCntrl,
                                              validator: (value) {
                                                if (value.isEmpty ||
                                                    value.length < 5) {
                                                  return 'Password is too short!';
                                                }
                                                return null;
                                              },
                                              onSaved: (String value) {
                                                print("desc");
                                                // _loginController.password=value;
                                                _authData['password'] = value;
                                              },
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Confirm Password'),
                                              obscureText: true,
                                              // controller: _passwordCntrl,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Password is required';
                                                }
                                                if (value !=
                                                    _passwordCntrl.text) {
                                                  return 'Confirm password doesnot match';
                                                }
                                                return null;
                                              },
                                              onSaved: (String value) {
                                                print("desc");
                                                // _loginController.password=value;
                                                _authData['confirmPassword'] =
                                                    value;
                                              },
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                        width: size.width * 0.4,
                                                        height: size.height * 0.05,
                                                        child: RaisedButton(
                                                            color: Colors.deepPurple,
                                                            onPressed: _onSignup,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                            child: Text("Sign up",
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 17)))),
                                                  ],
                                                ),
                                          ]))),

                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Container(
                                      width: size.width * 0.8,
                                      height: size.height * 0.05,
                                      child: FlatButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen(),
                                            ));
                                          },
                                          child: Text("Have an account? Log in",
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.normal)))),
                                ]),
                          )),
                    ),
                  ],
                )
              ],
            )),
      ],
    )));
  }

  _onSignup() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    // _loginController.phone=_authData['phone'];
    // _loginController.password=_authData['password'];
    _loginController.register(_authData);
    if (_loginController.status) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    } else {
      setState(() {
        msg = "Error in registration";
      });
    }
  }
}
