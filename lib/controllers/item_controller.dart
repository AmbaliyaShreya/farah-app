import 'dart:io';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:my_app/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemController extends ControllerMVC {
//   factory ItemController() {
//     if (_this == null) _this = ItemController._();
//     return _this;
//   }

//   ItemController._();
  ItemController(){}

  Dio dio = new Dio();
  bool isLoading = false;
  static ItemController _this;
  List<ItemModel> listItems = [];
  Response response;
  Future<void> getAllItems() async {
    print("in get all items");
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      final String url = "http://adsumoriginator.com/apidemo/api/list_item";

      response = await dio.get(url,
          options: Options(headers: {'Authorization': "Bearer " + token}));
      List<String> listImage;
      listItems.clear();
      response.data['data'].forEach((element) {
        listImage = [];
        if (element['image'] != null) {
          element['image'].forEach((element) {
            listImage.add(element);
          });
        }
        ItemModel imodel = ItemModel(
            id: element['id'],
            title: element['title'],
            description: element['description'],
            image: listImage);
        listItems.add(imodel);
      });
      // print("0000000000");
      // print(listItems[0].image);
      setState(() {
        listItems = listItems;
        isLoading = false;
      });
      // print(listItems[0].image[0]);
    } on DioError catch (e) {
      print(e.response.data);
      // setState(() {
      //   isLoading = false;
      // });
    }
    // print(isLoading);
  }
  ItemModel imodel;
  Future<void> getItem(int id) async {
    print("in get item by ID");
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      final String url = 'http://adsumoriginator.com/apidemo/api/get_item/$id';
      Response response;
      response = await dio.get(url,options: Options(headers: {'Authorization': "Bearer " + token}));
      List<String> imodelImage = [];
      response.data['data']['image'].forEach((element) {
        imodelImage.add(element);
      });
      imodel = ItemModel(
          id: response.data['data']['id'],
          title: response.data['data']['title'],
          description: response.data['data']['description'],
          image: imodelImage);
      imodelImage = [];
      setState(() {
        isLoading = false;
      });
      print(imodel.title);
    } on DioError catch (e) {
      print(e.response.data);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteItem(int id) async {
    setState(() {
      isLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      print("in deleteitem ---");
      final String url =
          'http://adsumoriginator.com/apidemo/api/delete_item/$id';
      Response response;
      response = await dio.delete(url,
          options: Options(headers: {'Authorization': "Bearer " + token}));
      // print(response);
      setState(() {
        isLoading = false;
      });
      // print(listItems[0].image[0]);
    } on DioError catch (e) {
      print(e.response.data);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createItem(Map<String, dynamic> _itemData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      List<MultipartFile> multipart = List<MultipartFile>();

      for (int i = 0; i < _itemData['image'].length; i++) {
        var path = await FlutterAbsolutePath.getAbsolutePath(_itemData['image'][i].identifier);
        multipart.add(await MultipartFile.fromFile(path, filename: DateTime.now().toString()));
      }

      FormData formData=FormData.fromMap({
        "title":_itemData['title'],
        "description":_itemData['description'],
        "image":multipart
      });
      final String url = "http://adsumoriginator.com/apidemo/api/create_item";
      Response response = await Dio().post(url,
          data: formData,
          options: Options(headers: {'Authorization': "Bearer " + token}));
      print("created data response");
      print(response.data.toString());
      setState(() {
        // createStatus=response.data['status'];
      });
    } on DioError catch (e) {
      print(e.response.data);
    }
  }
  Future<void> updateItem(Map<String, dynamic> _itemData) async {
    try {
      print("in update controller method");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');

      List<MultipartFile> multipart = List<MultipartFile>();
      print(_itemData['image'].runtimeType);
      if(_itemData['image'].runtimeType.toString()=="List<String>") {

        for (int i = 0; i < _itemData['image'].length; i++) {
          var savedImage=_itemData['image'][i].split('/');
          print(savedImage[savedImage.length-1]);
          savedImage=savedImage[savedImage.length-1];
          // savedImage=savedImage+".jpg";
          multipart.add(await MultipartFile.fromString(savedImage));
        }
      }else {
        for (int i = 0; i < _itemData['image'].length; i++) {
          var path = await FlutterAbsolutePath.getAbsolutePath(
              _itemData['image'][i].identifier);
          multipart.add(await MultipartFile.fromFile(
              path, filename: DateTime.now().toString()));
        }
      }
      FormData formData = FormData.fromMap({
        "title": _itemData['title'],
        "description": _itemData['description'],
        "image": multipart
      });
      final String url = 'http://adsumoriginator.com/apidemo/api/update_item_data/${_itemData['id']}';
      Response response;
      response = await Dio().post(url,
          data: formData,
          options: Options(headers: {'Authorization': "Bearer " + token}));
      print("updated data response");
      print(response.data.toString());
      setState(() {
        imageCache.clear();
        // updateStatus=response.data['status'];
      });
    } on DioError catch (e) {
      print(e.response.data);
    }
  }
}
