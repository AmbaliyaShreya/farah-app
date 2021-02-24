import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_app/controllers/item_controller.dart';
import 'package:my_app/models/item_model.dart';
import 'package:my_app/views/home_screen.dart';
import 'package:my_app/views/item_details_screen.dart';
import 'package:path/path.dart';

class CreateItem extends StatefulWidget {
  final int id;

  CreateItem(this.id);

  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends StateMVC<CreateItem> {
  // final _titleController = TextEditingController();
  // final _descriptionC = TextEditingController();
  ItemController _ic;
  bool flag = false;
  Map<String, dynamic> _itemData = {
    'id': 0,
    'title': '',
    'description': '',
    'image': []
  };

  _CreateItemState() : super(ItemController()) {
    this._ic = controller;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    if (widget.id != null) {
      _ic.getItem(widget.id);
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Add Item")),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      initialValue: widget.id == 0 ? "" : _ic.imodel.title,
                      // controller: _titleController,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(fontSize: 18),
                          border:
                              new OutlineInputBorder(borderSide: BorderSide())),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'title is required!';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _itemData['title'] = value;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    TextFormField(
                      // controller: _descriptionC,
                      initialValue:
                          widget.id == 0 ? "" : _ic.imodel.description,
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(fontSize: 18),
                          border:
                              new OutlineInputBorder(borderSide: BorderSide())),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'description is required!';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _itemData['description'] = value;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    FlatButton.icon(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      shape: new OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.deepPurple)),
                      textColor: Colors.deepPurple,
                      onPressed: onPickImages,
                      icon: Icon(Icons.image, size: 25),
                      label: Text("Upload Image"),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RaisedButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        color: Colors.deepPurple,
                        onPressed: () {
                          widget.id == 0
                              ? _onCreate(context)
                              : _onUpdate(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Save Item",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18))),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    images.length == 0
                        ? widget.id != 0
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: List.generate(
                                        _ic.imodel.image.length, (i) {
                                      return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Image.network(
                                            _ic.imodel.image[i],
                                            height: 150.0,
                                            width: 100.0,
                                          ));
                                    })))
                            : SizedBox()
                        : SizedBox(),
                    images.length != 0
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(images.length, (i) {
                                  Asset asset = images[i];
                                  return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: AssetThumb(
                                        asset: asset,
                                        width: 180,
                                        height: 180,
                                      ));
                                })))
                        : SizedBox(),
                    flag
                        ? Text(
                            "Please select image",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          )
                        : Text(''),
                  ]),
                ))));
  }

  List<Asset> images = List<Asset>();

  // Future<Asset> fileToAsset(File image) async {
  //   var uuid = Uuid();
  //   String fileName = basename(image.path);
  //   var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  //   return Asset(
  //       uuid.generateV4(), fileName, decodedImage.width, decodedImage.height);
  // }

  Future<void> onPickImages() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "App",
        ),
      );
      setState(() {
        images = resultList;
        if (images.length != 0) {
          flag = false;
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  _onCreate(BuildContext context) async {
    if (images.isEmpty) {
      setState(() {
        flag = true;
      });
    } else {
      _itemData['image'] = images;
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        print(_itemData['image']);
        await _ic.createItem(_itemData);

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                HomeScreen(),
          )).then((value) async {
            if (value == false) {
              await _ic.getAllItems();
            }
          });

      }
    }
  }

  _onUpdate(BuildContext context) async {
    print("in update method");
    ItemModel updateItem;
    if (images.isEmpty) {
      print("image is emp");
      _itemData['image'] = _ic.imodel.image;
    } else {
      print("image is not emp");
      _itemData['image'] = images;
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("form validated");
      _itemData['id'] = widget.id;
      print(_itemData['description']);
      await _ic.updateItem(_itemData);
      await _ic.getItem(widget.id).then((value){ Navigator.of(context).pop(false);});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
