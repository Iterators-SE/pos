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
  dynamic getProductDetails() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();
  }

  void deleteProduct() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();
    var deleteAllVariantsResult = await client.mutate(
      MutationOptions(
        document: gql(
          query.deleteAllVariants(
            int.parse(widget.productData['product']['id']),
          ),
        ),
      ),
    );

    if (deleteAllVariantsResult.data['deleteAllVariants'] != true) {
      return null;
    }
    var deleteProductResult = await client.mutate(
      MutationOptions(
        document: gql(
          query.deleteProduct(
            int.parse(widget.productData['product']['id']),
          ),
        ),
      ),
    );

    if (deleteProductResult.data['deleteProduct']) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InventoryList()),
          (route) => false);
    }
  }

  Widget isTaxable(bool taxable) {
    if (taxable) {
      return Text(
        "Taxes apply to this product",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
      );
    }
    return Text(
      "Taxes do not apply to this product",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
    );
  }

  void _editProductDetails() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditDetails(productData: widget.productData['product']),
      ),
    );
  }

  dynamic showVariant() {
    List<Widget> widgets = [];

    for (var i = 0; i < widget.productData['variants'].length; i++) {
      widgets.add(
        variantBox(
          widget.productData['variants'][i]['variantname'],
          widget.productData['variants'][i]['quantity'],
          widget.productData['variants'][i]['price'],
        ),
      );
    }

    return Container(
      width: 350,
      child: Column(children: widgets),
    );
  }

  Widget variantBox(String name, int quantity, int price) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                readOnly: true,
                initialValue: '$name',
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: TextFormField(
                readOnly: true,
                initialValue: '$quantity',
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: TextFormField(
                readOnly: true,
                initialValue: '$price',
                decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
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
              onPressed: () {
                _editProductDetails();
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.productData['product']['photolink']),
            SizedBox(height: 25),
            Container(
              width: 350,
              child: TextFormField(
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                initialValue: widget.productData['product']['productname'],
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 350,
              child: TextFormField(
                minLines: 1,
                maxLines: 5,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                initialValue: widget.productData['product']['description'],
                decoration: InputDecoration(
                  labelText: 'Product Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            isTaxable(widget.productData['product']['taxable']),
            SizedBox(height: 20),
            Text(
              "Variants",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            showVariant(),
        ],
        ),
      ) 
    

      // Container(
      //     child: Column(
      //   children: [
      //     Container(
      //       height: 500,
      //       child: Column(
      //         children: [
      //           Image.network(widget.productData['photolink']),
      //           Padding(
      //             padding: EdgeInsets.only(top: 25),
      //             child: Text(
      //               widget.productData['productname'],
      //               style: TextStyle(
      //                 fontSize: 50.0,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //               textAlign: TextAlign.center,
      //             ),
      //           ),
      //           SizedBox(
      //             height: 15.0,
      //           ),
      //           Text(
      //             widget.productData['description'],
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 25.0,
      //               fontWeight: FontWeight.w100,
      //             ),
      //           ),
      //           SizedBox(
      //             height: 10.0,
      //           ),
      //           Text(
      //             "Taxable: ${widget.productData['taxable']}",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //               fontSize: 20.0,
      //               fontWeight: FontWeight.w100,
      //             ),
      //           ),
      //           // _variantWidget(10),
      //         ],
      //       ),
      //     ),
      //     // Container(
      //     //   height: 250,
      //     //   width: 350,
      //     //   child: Column(
      //     //     children:

      //     //   )

      //     // )
      //   ],
      // )),
    );
  }
}
