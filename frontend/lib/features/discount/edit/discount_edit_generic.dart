import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../screen/discount_screen.dart';
import '../screen/widgets/subtitle.dart';
import '../screen/widgets/title.dart';
import 'discount_edit_custom.dart';

class EditGenericDiscount extends StatefulWidget {

  final int id;

  EditGenericDiscount({Key key, this.id}): super(key: key);

  @override
  _EditGenericDiscountState createState() => _EditGenericDiscountState();
}

class _EditGenericDiscountState extends State<EditGenericDiscount> {
  String _description;
  int _percentage;
  List<int> includedProducts = [];

  final _formKey = GlobalKey<FormState>();
  List products = [];
  List<bool> checkBox = [];

  dynamic getDiscount() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('POS_TOKEN');
    GraphQLConfiguration.setToken(token);
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(document: gql(query.getDiscount(widget.id))),
    );
    return result.data['getDiscount'];
  }

  void updateDiscount() async {
    _formKey.currentState.save();
    print(_description);
    print(includedProducts);
    print(_percentage);
    print(widget.id);
    if (_formKey.currentState.validate()) {
      var query = MutationQuery();
      var client = GraphQLConfiguration().clientToQuery();

      var result = await client.query(QueryOptions(
          document: gql(query.updateGenericDiscount(
        widget.id,
        _description,
        _percentage,
        includedProducts,
      ))));
      print(result);
      if (!result.hasException) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DiscountScreen()));
      }
    }
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
    setState(() {
      _description = result.data['description'];
      _percentage = result.data['percentage'];
    });

    return result.data['getProducts'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: FutureBuilder(
            future: getDiscount(),
            builder: (context, snapshot) {
              return ListView(
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
                        initialValue: snapshot.data['description'],
                        validator: (value) =>
                            value.isEmpty ? "Please enter description" : null,
                        onSaved: (value) {
                          setState(() {
                            _description = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            labelText: "Discount Name")),
                  ),
                  subtitle("Product:"),
                  FutureBuilder(
                      future: getProducts(),
                      builder: (context, snapshot2) {
                        if (snapshot2.data == null) {
                          return Text('No Products found in the inventory');
                        }
                        if (products.length < snapshot2.data.length) {
                          for (var i = 0; i < snapshot2.data.length; i++) {
                            products.add(snapshot2.data[i]);
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
                                        print(products[index]['id']);
                                        print(products);
                                        print(includedProducts);
                                        setState(() {
                                          checkBox[index] = value;
                                          if (checkBox[index] == false) {
                                            if (includedProducts.contains(
                                                int.parse(
                                                    products[index]['id']))) {
                                              includedProducts.remove(int.parse(
                                                  products[index]['id']));
                                            }
                                          } else {
                                            includedProducts.add(int.parse(
                                                products[index]['id']));
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
                          initialValue: snapshot.data['percentage'].toString(),
                          validator: (value) =>
                              value.isEmpty ? 'Please enter percentage' : null,
                          onSaved: (value) => _percentage = int.parse(value),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              labelText: "Percentage")),
                    ),
                  )
                ],
              );
            }),
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
            icon: Icon(Icons.check_box_outlined),
            label: Text("Create Custom Discount",
                style: TextStyle(fontFamily: "Montserrat Bold")),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditCustomDiscount(id: widget.id)));
            }),
        FloatingActionButton.extended(
            icon: Icon(Icons.check_box_outlined),
            label:
                Text("Save", style: TextStyle(fontFamily: "Montserrat Bold")),
            onPressed: updateDiscount),
      ],
    );
  }
}
