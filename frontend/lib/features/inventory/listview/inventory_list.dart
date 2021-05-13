import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../add/add_products.dart';
import '../details/product_details.dart';
// import '../search/search.dart';

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
  bool isSearching = false;
  String productToSearch = "";

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

    return result.data['getProducts'];
  }

  dynamic getVariants(int productId) async {
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

  dynamic buildListTile(int index, dynamic snapshot) {
    var prices = [];
    var quantity = [];

    // ignore: lines_longer_than_80_chars
    for (var i = 0; i < snapshot.data[index]['variants'].length; i++) {
      quantity.add(snapshot.data[index]['variants'][i]['quantity']);
    }
    for (var i = 0; i < snapshot.data[index]['variants'].length; i++) {
      prices.add(snapshot.data[index]['variants'][i]['price']);
    }
    var min = prices.reduce((curr, next) => curr < next ? curr : next);
    var max = prices.reduce((curr, next) => curr > next ? curr : next);

    if(isSearching){
      if(snapshot.data[index]['product']['productname']
        .toLowerCase()
        .contains(productToSearch.toLowerCase())
      ){
        return Card(
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          radius: 40,
          backgroundImage:
              NetworkImage(snapshot.data[index]['product']['photolink']),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            snapshot.data[index]['product']['productname'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              // ignore: lines_longer_than_80_chars
              "${snapshot.data[index]['product']['description']}",
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Price: $min - $max',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 25),
                Text(
                  // ignore: lines_longer_than_80_chars
                  'Quantity: ${quantity.reduce((value, element) => value + element)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            )
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
      }
    } else {
      return Container(
      height: 115,
      child: Card(
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          radius: 38,
          backgroundImage:
              NetworkImage(snapshot.data[index]['product']['photolink']),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text(
            snapshot.data[index]['product']['productname'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              // ignore: lines_longer_than_80_chars
              "${snapshot.data[index]['product']['description']}",
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Price: $min - $max',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 25),
                Text(
                  // ignore: lines_longer_than_80_chars
                  'Quantity: ${quantity.reduce((value, element) => value + element)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            )
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
      elevation: 5,
     margin: EdgeInsets.fromLTRB(10, 11, 10, 0)
    ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text('Inventory')
            : TextField(
                onChanged: (value) {
                  setState(() {
                    productToSearch = value;
                    print(value);
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search product",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      productToSearch = "";
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
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
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              if (snapshot.data.isEmpty) {
                return Container(
                    child: Center(
                  child: Text("Your inventory is empty."),
                ));
              } 

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return buildListTile(index, snapshot);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
