import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_app/controllers/item_controller.dart';
import 'package:my_app/main.dart';
import 'package:my_app/views/create_item.dart';
import 'package:my_app/views/item_details_screen.dart';
import 'package:my_app/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends StateMVC<HomeScreen> {
  ItemController _ic;

  _HomeScreenState() : super(ItemController()) {
    this._ic = controller;
  }

  @override
  void initState() {
    setState(() {
      _ic.getAllItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All items"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateItem(0),
                ));
              }),
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          })
        ],
      ),
      body:
      WillPopScope(
        onWillPop: () {
          print('Back button pressed!');
          // Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: _ic.isLoading
              ? Container(child: Center(child: CircularProgressIndicator()))
              : ListView.builder(
            itemCount: _ic.listItems.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black38, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                            height: 200,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: List.generate(
                                        _ic.listItems[index].image.length,
                                            (i) {
                                          return Image.network(
                                            _ic.listItems[index].image[i],
                                            height: 150.0,
                                            width: 120.0,
                                          );
                                        })
                                )
                            )
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Text(
                            _ic.listItems[index].title,
                          ),
                        ),
                        Container(
                          // alignment: TextA,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Text(
                            _ic.listItems[index].description,
                          ),
                        ),
                      ],
                    )),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ItemDetailsScreen(_ic.listItems[index].id),
                  )).then((value) async {
                    if (value == false) {await _ic.getAllItems();}
                  });
                },
              );
            },
          )),
    ));
  }
}
