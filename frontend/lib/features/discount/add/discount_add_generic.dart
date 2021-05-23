import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../reusable_widgets/subtitle.dart';
import '../reusable_widgets/title.dart';
import 'discount_add_custom.dart';

class AddGenericDiscount extends StatefulWidget {
  @override
  _AddGenericDiscountState createState() => _AddGenericDiscountState();
}

class _AddGenericDiscountState extends State<AddGenericDiscount> {
  String _description;
  int _percentage;
  List<int> includedProducts = [];

  List products = [];
  List<bool> checkBox = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void addDiscount() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    await client.query(QueryOptions(
        document: gql(query.createGenericDiscount(
            _description, _percentage, includedProducts))));
  }

  dynamic getProducts() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('POS_TOKEN');
    GraphQLConfiguration.setToken(token);

    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(document: gql(query.getProducts())),
    );

    print(result.data['getProducts']);
    return result.data['getProducts'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 20),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            title("Discount"),
            subtitle("Name:"),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                  validator: (value) =>
                      value.isEmpty ? "Please enter description" : null,
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      labelText: "Discount Name")),
            ),
            subtitle("Product:"),
            FutureBuilder(
                future: getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Text('No Products found in the inventory');
                  }
                  if (snapshot.data.length == 0) {
                    return Text('No Products found in the inventory');
                  }
                  if (products.length < snapshot.data.length) {
                    for (var i = 0; i < snapshot.data.length; i++) {
                      products.add(snapshot.data[i]);
                    }
                  }
                  if (checkBox.length < products.length) {
                    for (var i = 0; i < products.length; i++) {
                      checkBox.add(false);
                    }
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Checkbox(
                                value: checkBox[index],
                                onChanged: (value) {
                                  setState(() {
                                    checkBox[index] = value;
                                    if (checkBox[index] == false) {
                                      if (includedProducts.contains(
                                          int.parse(products[index]['id']))) {
                                        includedProducts.remove(
                                            int.parse(products[index]['id']));
                                      }
                                    } else {
                                      includedProducts.add(
                                          int.parse(products[index]['id']));
                                    }
                                  });
                                }),
                            Text(products[index]['productname'])
                          ],
                        );
                      });
                }),
            subtitle("Discount Percentage:"),
            Container(
              padding: EdgeInsets.only(right: 200),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                child: TextFormField(
                    validator: (value) =>
                        value.isEmpty ? 'Please enter percentage' : null,
                    onChanged: (value) => _percentage = int.parse(value),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        labelText: "Percentage")),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
            icon: Icon(Icons.check_box_outlined),
            label: Text("Create Custom Discount",
                style: TextStyle(fontFamily: "Montserrat Bold")),
            onPressed: (){
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  AddCustomDiscount()));
            }),
        FloatingActionButton.extended(
            icon: Icon(Icons.check_box_outlined),
            label:
                Text("Save", style: TextStyle(fontFamily: "Montserrat Bold")),
            onPressed: addDiscount),
      ],
    );
  }
}
