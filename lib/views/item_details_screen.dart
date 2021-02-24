import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_app/controllers/item_controller.dart';
import 'package:my_app/views/create_item.dart';
import 'package:my_app/views/home_screen.dart';

class ItemDetailsScreen extends StatefulWidget {
  int id;

  ItemDetailsScreen(this.id);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends StateMVC<ItemDetailsScreen> {
  ItemController _ic;

  _ItemDetailsScreenState() : super(ItemController()) {
    this._ic = controller;
  }

  @override
  void initState() {
    setState(() {
      _ic.getItem(widget.id);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id.toString()),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await _ic.deleteItem(widget.id).then((value) {
                  _ic.getAllItems();
                  Navigator.of(context).pop();
                });
              }),
        ],
      ),
      body: WillPopScope(
          onWillPop: () {
            print('Back button pressed!');
            Navigator.pop(context, false);
            return Future.value(false);
          },
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: _ic.isLoading
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                            height: 200,
                            child: SingleChildScrollView(
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
                                    })))),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Text(
                            _ic.imodel.title,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Text(
                            _ic.imodel.description,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateItem(_ic.imodel.id),
                              ));
                            }),
                      ],
                    ))),
    );
  }
// Future<bool> postBack() async {
//   await _ic.getAllItems().then((value) {
//     Navigator.of(context).pop();
//     return true;});
//   return false
// }
}
