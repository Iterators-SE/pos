import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../add/add_products.dart';
import '../details/product_details.dart';

/*
NOTE:
  if youre getting failed to load network image errors, just run this
  project using the code below:

  flutter run -d chrome --web-renderer html


  Until a fix is found for this issue use code below for the release version:

  flutter build web --web-renderer html --release

  references: https://doalongme.com/failed-to-load-network-image-flutter-web/

*/

class InventoryList extends StatefulWidget {
  @override
  IinventoryListState createState() => IinventoryListState();
}

class IinventoryListState extends State<InventoryList> {
  dynamic getProducts() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('POS_TOKEN');
    GraphQLConfiguration.setToken(token);
    print(token);

    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(document: gql(query.getProducts())),
    );

    // print(result.data['getProducts']);
    // print(result.data['getProducts'].length);
    return result.data['getProducts'];
  }

  dynamic getVariants(var productId) async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(document: gql(query.getVariants(productId))),
    );

    return result.data['getVariants'];
  }

  dynamic getProductsAndVariants() async {
    var products = await getProducts();
    var productsAndVariants = [];

    for (var i = 0; i < products.length; i++) {
      var variants = await getVariants(int.parse(products[i]['id']));
      print(variants);
      productsAndVariants.add({"variants": variants, "product": products[i]});
    }

    return productsAndVariants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add"),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
      ),
      body: Container(
        child: FutureBuilder(
          future: getProductsAndVariants(),
          builder: (context, snapshot) {
            // print(snapshot.data.runtimeType);

            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              // print("data in snapshot");
              // print(snapshot.data);

              if (snapshot.data.isEmpty) {
                return Container(
                    child: Center(
                  child: Text("Your inventory is empty."),
                ));
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var prices = [];

                  for (var i = 0;
                      i < snapshot.data[index]['variants'].length;
                      i++) {
                    prices.add(snapshot.data[index]['variants'][i]['price']);
                  }
                  print(prices);

                  var min =
                      prices.reduce((curr, next) => curr < next ? curr : next);

                  var max =
                      prices.reduce((curr, next) => curr > next ? curr : next);

                  return Card(
                    child: ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            snapshot.data[index]['product']['photolink']),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          snapshot.data[index]['product']['productname'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // ignore: lines_longer_than_80_chars
                            "${snapshot.data[index]['product']['description'].substring(0, 15)}...",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Price: $min - $max',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      productData: snapshot.data[index],
                                    )));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
