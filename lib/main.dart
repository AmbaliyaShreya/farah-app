import 'package:flutter/material.dart';
import 'package:my_app/route_generator.dart';
import 'package:my_app/views/home_screen.dart';
import 'package:my_app/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
String _token;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _prefs =await SharedPreferences.getInstance();
  _token = _prefs.getString('token');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _token==null?LoginScreen():HomeScreen(),
    );
  }
}
