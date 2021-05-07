import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/features/discount/dicount_page/discountpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/themes/xpos_theme.dart';
import '../../../providers/user_provider.dart';
import '../../inventory/listview/inventory_list.dart';
import '../../orders/screens/order_screen.dart';
import '../models/menu_item.dart';
import '../presenters/home_screen_presenter.dart';
import '../views/home_screen_view.dart';
import 'widget/drawer_list_tile.dart';
import 'widget/menu_item_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeScreenView {
  HomeScreenPresenter _presenter;

  @override
  String get persistKey => 'menu';

  @override
  Map<String, Function> defaultItemMap;

  @override
  List<String> drawerList;

  @override
  List<MenuItem> menuItems;

  @override
  Future<List<MenuItem>> getMenuItems() async {
    final preferences = await SharedPreferences.getInstance();

    var list = await preferences.getStringList(persistKey);

    var menuList = list.map((i) {
          final json = jsonDecode(i);

          return MenuItem(
            option: json['option'],
            url: json['url'],
            onTap: defaultItemMap[json['option'].toString()],
          );
        }).toList() ??
        menuItems;

    return menuList;
  }

  @override
  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;

      setState(() {
        final item = menuItems.removeAt(oldIndex);
        menuItems.insert(newIndex, item);
      });

      persistOrder();
    }
  }

  @override
  void persistOrder() async {
    final preferences = await SharedPreferences.getInstance();
    final stringList = menuItems
        .map((e) => '{"option": "${e.option}", "url": "${e.url}"}')
        .toList();

    await preferences.setStringList(persistKey, stringList);
  }

  @override
  void initState() {
    _presenter = HomeScreenPresenter();
    _presenter.attachView(this);

    drawerList = [
      "Add User",
      "Edit Business Detail",
      "Tutorial",
      "Upgrade to Pro"
    ];

    defaultItemMap = {
      'PROCESS ORDERS': () => _presenter.navigate(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(),
            ),
          ),
      'SEE STOCK': () {},
      'DISCOUNTS': () => _presenter.navigate(
            context,
            MaterialPageRoute(
              builder: (context) => DiscountPage(),
            ),
          ),
      'USERS': () {},
      'PRODUCTS': () => _presenter.navigate(
            context,
            MaterialPageRoute(
              builder: (context) => InventoryList(),
            ),
          ),
    };

    menuItems = [
      MenuItem(
        option: "PROCESS ORDERS",
        url: "assets/images/orders.png",
        onTap: defaultItemMap['PROCESS ORDERS'],
      ),
      MenuItem(
        option: "PRODUCTS",
        url: "assets/images/orders.png",
        onTap: defaultItemMap['PRODUCTS'],
      ),
      MenuItem(
        option: "DISCOUNTS", 
        url: "assets/images/coffee-icon.png",
        onTap: defaultItemMap['DISCOUNTS']
        ),
      MenuItem(option: "USERS", url: "assets/images/coffee-icon.png"),
    ];

    getMenuItems().then(
      (value) => value.isNotEmpty
          ? setState(() => menuItems = value ?? menuItems)
          : null,
      onError: (error) => setState(() => menuItems = menuItems),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "XPOS",
          textAlign: TextAlign.center
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<UserProvider>(context, listen: false)
                .logout(context),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(XPosTheme.primaryColor),
          child: Container(
            margin: EdgeInsets.only(top: 250),
            child: ListView(
              children:
                  drawerList.map((item) => DrawerListItem(item: item)).toList(),
            ),
          ),
        ),
      ),
      body: ReorderableListView(
        header: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text("Coffee Shop",
                //   style: TextStyle(
                //     fontFamily: "Montserrat Bold", 
                //     fontSize: 30
                //   )
                // ),
                Image(
                  height: 40,
                  image: AssetImage("assets/images/coffee-icon.png"),
                )
              ],
            ),
          ),
        ),
        children: menuItems
            .map((element) => MenuItemCard(
                  key: Key(element.option),
                  element: element,
                ))
            .toList(),
        onReorder: onReorder,
      ),
    );
  }
}
