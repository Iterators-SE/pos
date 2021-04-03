import 'package:flutter/material.dart';
import 'menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Menu> items = [
    Menu(id: '0', option: "PROCESS ORDERS", url: "assets/images/orders.png"),
    Menu(id: '1', option: "SEE STOCK", url: "assets/images/stocks.png"),
    Menu(id: '2', option: "DISCOUNTS", url: "assets/images/coffee-icon.png"),
    Menu(id: '3', option: "USERS", url: "assets/images/coffee-icon.png"),
    Menu(id: '3', option: "PRODUCTS", url: "assets/images/coffee-icon.png")
  ];

  List<String> drawerLists = [
    "Add User",
    "Edit Business Detail",
    "Tutorial",
    "Upgrade to Pro",
    "Log out"
  ];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Menu item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[400],
        ),
        drawer: Drawer(
          child: Container(
              color: Colors.grey,
              child: Container(
                margin: EdgeInsets.only(top:250),
                child: ListView(
                children: drawerLists.map((list) {
                  return drawerList(list);
                }).toList(),
              ),
              ) 
              ),
        ),
        body: ReorderableListView(
            header: Center(
                child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Coffee Shop",
                              style: TextStyle(
                                  fontFamily: "Montserrat Bold", fontSize: 30)),
                          Image(
                            height: 40,
                            image: AssetImage("assets/images/coffee-icon.png"),
                          )
                        ]))),
            children: items.map((task) {
              return menuWidget(task);
            }).toList(),
            onReorder: _onReorder));
  }
}