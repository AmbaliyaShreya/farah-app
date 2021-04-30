import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:my_app/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends ControllerMVC {
//   factory Controller() {
//     if (_this == null) _this = Controller._();
//     return _this;
//   }
//   static Controller _this;
//   Controller._();
  Controller();
  bool status=false;
  String get phone=>LoginModel.phone;
  String get password=>LoginModel.password;

  Future<void> register(Map<String, String> _authData) async{
    try {
      print("in Register---");
      // print(_authData['phone']);
      final String url = "http://adsumoriginator.com/apidemo/api/register";
      Response response;
      response = await Dio().post(url, data: _authData);
      // response=await http.post(url,body: _authData);
      // print(response.data);
      setState(() {
        status=true;
      });
    }on DioError catch(e){
      print(e.response.data);
      setState(() {status=false;});
    }
  }
  Future<void> login(Map<String, String> _authData) async{

    final Dio dio=new Dio();
    try {

      print("in login---");
      // print(_authData['phone']);
      final String url = "http://adsumoriginator.com/apidemo/api/login";
      Response response;
      response = await dio.post(url, data: _authData);
      // print(response.data['data']['token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['data']['token']);
      status=true;
      setState(() { });
    }on DioError catch(e){
      print(e.response.data);
        // setState(() {status=false; });
    }
  }
}
