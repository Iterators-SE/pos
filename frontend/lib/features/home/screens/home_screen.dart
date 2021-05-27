import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/themes/xpos_theme.dart';
// import '../../../models/product.dart';
// import '../../../models/product_variant.dart';
import '../../../providers/user_provider.dart';
// import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../../discount/screen/discount_screen.dart';
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
              builder: (context) => DiscountScreen(),
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
          onTap: defaultItemMap['DISCOUNTS']),
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

  // dynamic getData(BuildContext context) async {
  //   var x = Provider.of<InventoryRepository>(context, listen: false);

  //   // var newProd = NewProduct(
  //   //   description: "Namiit",
  //   //   isTaxable: true,
  //   //   name: "Fake",
  //   //   photoLink: "Fake Link",
  //   // );
  //   // newProd.variants.add(NewVariant(
  //   //   name: "Small",
  //   //   quantity: 100,
  //   //   price: 100,
  //   // ));
  //   // newProd.variants.add(NewVariant(
  //   //   name: "Medium",
  //   //   quantity: 100,
  //   //   price: 100,
  //   // ));
  //   // newProd.variants.add(NewVariant(
  //   //   name: "Large",
  //   //   quantity: 100,
  //   //   price: 100,
  //   // ));
  //   var response = await x.changeProductDetails(
  //     product: Product(
  //       id: 80,
  //       name: "KEKEKEEKEKEEK",
  //       description: "Namiit",
  //       photoLink: "Fake Linkkkkkkkkk",
  //       isTaxable: false,
  //       variants: [
  //         ProductVariant(
  //           variantId: 53,
  //           variantName: "Large",
  //           price: 100,
  //           quantity: 100,
  //         ),
  //         ProductVariant(
  //           variantId: 52,
  //           variantName: "Medium",
  //           price: 100,
  //           quantity: 100,
  //         ),
  //         ProductVariant(
  //           variantId: 51,
  //           variantName: "Small",
  //           price: 100,
  //           quantity: 100
  //         ),
  //       ]
  //     )
  //   );

  //   var result = response.fold(
  //     (failure) => false,
  //     (product) => product
  //   );
  //   print(await result);
  //   // print(await response.runtimeType);
  // }

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
          child: Image(image: AssetImage("assets/images/xpos_home_logo.png")),
        ),
        children: menuItems
            .map((element) =>
                MenuItemCard(key: Key(element.option), element: element))
            .toList(),
        onReorder: onReorder,
      ),
    );
  }
}
