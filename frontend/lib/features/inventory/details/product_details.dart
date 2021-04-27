import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../listview/inventory_list.dart';

class ProductDetails extends StatefulWidget {
  final Map productData;

  ProductDetails({Key key, @required this.productData}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  void deleteProduct() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.mutate(MutationOptions(
        document:
            gql(query.deleteProduct(int.parse(widget.productData['id'])))));

    if(result.data['deleteProduct']){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InventoryList()),
          (route) => false);
    }

  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: null),
        ],
      ),
      body: ListView(
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
        ],
      ),
    );
  }
}
