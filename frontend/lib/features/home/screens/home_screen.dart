import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: Text("XPOS", textAlign: TextAlign.center),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<UserProvider>(context, listen: false)
                .logout(context),
          )
        ],
      ),
      body: ReorderableListView(
        header: Center(
          child: Image(image: AssetImage("assets/images/xpos_home_logo.png")),
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
