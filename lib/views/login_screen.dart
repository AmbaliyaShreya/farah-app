import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:my_app/controllers/login_controller.dart';
import 'package:my_app/views/home_screen.dart';
import 'package:my_app/views/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  // Controller _loginController = Controller();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String msg='';
  bool rememberCheck = false;
  Controller _loginController;
  _LoginScreenState():super(Controller()){
    this._loginController=controller;
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _phoneCntrl=TextEditingController();
    final _passwordCntrl=TextEditingController();
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
            margin: EdgeInsets.fromLTRB(8, 250, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 35),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 28,
                            letterSpacing: 1))),
                Stack(
                  clipBehavior: Clip.none, children: [
                    Container(
                      // color: Colors.black38,
                      child: Image.asset(
                        "assets/images/Union3.png",
                        fit: BoxFit.fill,
                        height: 440,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 35,
                      right: 35,
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  SizedBox(height: 10),
                                  Text(msg,style:TextStyle(color: Colors.redAccent,fontSize: 20)),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: 'Phone'),
                                    keyboardType: TextInputType.phone,
                                    controller: _phoneCntrl,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Phone number is required!';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {

                                      // _loginController.phone=value;
                                      _authData['phone'] = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Text("Password",
                                  //     style: TextStyle(
                                  //         color: Colors.black38, fontSize: 15)),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: 'Password'),
                                    obscureText: true,
                                    controller: _passwordCntrl,
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 5) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {

                                      // _loginController.password=value;
                                      _authData['password'] = value;
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: rememberCheck,
                                        onChanged: (newValue) {
                                          setState(() {
                                            rememberCheck = newValue;
                                          });
                                        },
                                      ),
                                      Text("Remember me",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: size.width*0.06,
                                      ),
                                      Container(
                                          child: TextButton(
                                        child: Text(
                                          "Forgot your password?",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        onPressed: () {},
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height*0.009,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: size.width*0.4,
                                          height: size.height*0.05,
                                          child: ElevatedButton(
                                          // color: Colors.deepPurple,
                                          onPressed: _onLogin,
                                              // shape: RoundedRectangleBorder(
                                              //   borderRadius: BorderRadius.circular(10)
                                              // ),
                                          child: Text("Login",
                                              style: TextStyle(
                                                  color: Colors.white,fontSize: 17)))
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height*0.001,
                                  ),
                                  Container(
                                      width: size.width*0.8,
                                      height: size.height*0.05,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen(),));
                                          },
                                          child: Text("Don't have an account? Sign Up",
                                              style: TextStyle(
                                                  color: Colors.black38,fontSize: 17,fontWeight: FontWeight.normal)))
                                  ),

                                ]

                            ),
                          )),
                    ),
                    Positioned(
                      bottom:-55,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width*0.05,
                        ),
                        Container(
                            width: size.width*0.4,
                            height: size.height*0.06,
                            child: ElevatedButton.icon(
                              icon: Image.asset("assets/images/facebooklogo.png",width: 25,),
                                // color: Colors.white,
                                onPressed: () {},
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10)
                                // ),
                                label: Text("Facebook",
                                    style: TextStyle(
                                        color: Colors.indigo,fontSize: 17)))
                        ),
                        SizedBox(
                          width: size.width*0.05,
                        ),
                        Container(
                            width: size.width*0.4,
                            height: size.height*0.06,
                            child: ElevatedButton.icon(
                                icon: Image.asset("assets/images/googlelogo.png",width: 25,),
                                // color: Colors.white,
                                onPressed: () {},
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10)
                                // ),
                                label: Text("Google",
                                    style: TextStyle(
                                        color: Colors.red,fontSize: 17)))
                        ),
                      ],

                    )
                    ),
                    Positioned(
                        bottom:-120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width*0.3,
                            ),
                            Container(
                                width: size.width*0.4,
                                height: size.height*0.08,
                                child: TextButton(
                                  child: Text(
                                    "Continue as Guest",
                                    style: TextStyle(fontSize: 15,color: Colors.white),
                                  ),
                                  onPressed: () {},
                                )
                            ),
                          ],
                        )
                    )
                  ],
                )
              ],
            )),
      ],
    )));
  }

  Map<String, String> _authData = {
    'phone': '',
    'password': '',
  };
  _onLogin()async{
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    await _loginController.login(_authData);

      if (_loginController.status) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
  }
}
