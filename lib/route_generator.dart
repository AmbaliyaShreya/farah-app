import 'package:flutter/material.dart';
import 'package:my_app/views/home_screen.dart';
import 'package:my_app/views/login_screen.dart';
class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/home':
      // var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}