import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../edit/edit_details.dart';
import '../listview/inventory_list.dart';

class ProductDetails extends StatefulWidget {
  final Map productData;

  ProductDetails({Key key, @required this.productData}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  dynamic getVariants() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    print(widget.productData['id']);

    var result = await client.query(QueryOptions(
        document: gql(query.getVariants(int.parse(widget.productData['id'])))));

    print(result.data);

    return result.data['getVariants'];
  }

  void deleteProduct() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var deleteAllVariantsResult = await client.mutate(MutationOptions(
        document:
            gql(query.deleteAllVariants(int.parse(widget.productData['id'])))));

    print(deleteAllVariantsResult);
    if (deleteAllVariantsResult.data['deleteAllVariants'] != true) {
      print("dis  ran!");
      return null;
    }

    var deleteProductResult = await client.mutate(MutationOptions(
        document:
            gql(query.deleteProduct(int.parse(widget.productData['id'])))));

    if (deleteProductResult.data['deleteProduct']) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InventoryList()),
          (route) => false);
    }
  }

  void _editProductDetails() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => EditDetails(productData: widget.productData)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    getVariants();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                deleteProduct();
              }),
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                _editProductDetails();
              }),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Container(
            height: 500,
            child: ListView(
              children: [
                Image.network(widget.productData['photolink']),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    widget.productData['productname'],
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  widget.productData['description'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Taxable: ${widget.productData['taxable']}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                // _variantWidget(10),
              ],
            ),
          ),
          Container(
            height: 250,
            width: 350,
            child: FutureBuilder(
                future: getVariants(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading")));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data.length);
                          print(snapshot.data[index]);
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // ignore: lines_longer_than_80_chars
                                Text("Variant Name: ${snapshot.data[index]['variantname']}"),
                                Text("Price: ${snapshot.data[index]['price']}"),
                                // ignore: lines_longer_than_80_chars
                                Text("Quantity: ${snapshot.data[index]['quantity']}"),
                              ],
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      )),
    );
  }
}
