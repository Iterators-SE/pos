import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/themes/config.dart';
import '../../../providers/user_provider.dart';
import '../../discount/screen/discount_screen.dart';
import '../../inventory/screens/inventory_list_screen.dart';
import '../../orders/screens/order_screen.dart';
import '../../profile/screens/page/profile_page.dart';
import '../../tax/screens/tax_list_screen.dart';
import '../../transactions/screens/transaction_screen.dart';
import '../models/menu_item.dart';
import '../presenters/home_screen_presenter.dart';
import '../views/home_screen_view.dart';
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
    }

    setState(() {
      final item = menuItems.removeAt(oldIndex);
      menuItems.insert(newIndex, item);
    });

    persistOrder();
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

    defaultItemMap = {
      'PROCESS ORDERS': () => _presenter.navigate(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(),
            ),
          ),
      'DISCOUNTS': () => _presenter.navigate(
            context,
            MaterialPageRoute(
              builder: (context) => DiscountScreen(),
            ),
          ),
      'INVENTORY': () => _presenter.navigate(
            context,
            MaterialPageRoute(builder: (context) => InventoryListScreen()),
          ),
      'TAXES': () => _presenter.navigate(
          context, MaterialPageRoute(builder: (context) => TaxListScreen())),
      'TRANSACTIONS': () => _presenter.navigate(context,
          MaterialPageRoute(builder: (context) => TransactionScreen())),
      'USER': () => _presenter.navigate(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          ),
    };

    menuItems = [
      MenuItem(
        option: "PROCESS ORDERS",
        url: "assets/images/processorders.png",
        onTap: defaultItemMap['PROCESS ORDERS'],
      ),
      MenuItem(
        option: "INVENTORY",
        url: "assets/images/inventory.png",
        onTap: defaultItemMap['INVENTORY'],
      ),
      MenuItem(
          option: "DISCOUNTS",
          url: "assets/images/discount.png",
          onTap: defaultItemMap['DISCOUNTS']),
      MenuItem(
        option: "TAXES",
        url: "assets/images/taxes.png",
        onTap: defaultItemMap['TAXES'],
      ),
      MenuItem(
        option: "USER",
        url: "assets/images/user.png",
        onTap: defaultItemMap['USER'],
      ),
      MenuItem(
        option: "TRANSACTIONS",
        url: "assets/images/user.png",
        onTap: defaultItemMap['TRANSACTIONS'],
      ),
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
        backgroundColor: xposGreen[300],
        elevation: 0,
        //leading: Icon(Icons.segment),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              ),
            onPressed: () => Provider.of<UserProvider>(context, listen: false)
                .logout(context),
          )
        ],
      ),
      drawer: Drawer(
      ),
      body: ReorderableListView(
        header: Container(
          margin: EdgeInsets.only(bottom: 40),
          height: 125,
          decoration: BoxDecoration(
            color: xposGreen[300],
            borderRadius: BorderRadius.only(
              //bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600],
                offset: Offset(0, 10.0),
                blurRadius: 25,
                spreadRadius: 1.50
              )
            ]
          ),
          //margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Welcome back",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            )
          ),
        children: menuItems
            .map((element) => MenuItemCard(
                  key: Key(element.option),
                  element: element,
                  imagePath: element.url,
                ))
            .toList(),
        onReorder: onReorder,
      ),
    );
  }
}
