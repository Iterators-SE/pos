import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../discount_page/discountpage.dart';
import '../reusable_widgets/subtitle.dart';
import '../reusable_widgets/time_date.dart';
import '../reusable_widgets/title.dart';
import 'discount_edit_generic.dart';

class EditCustomDiscount extends StatefulWidget {
  final int id;
  EditCustomDiscount({this.id});
  @override
  _EditCustomDiscountState createState() => _EditCustomDiscountState();
}

class _EditCustomDiscountState extends State<EditCustomDiscount> {
  String _description;
  int _percentage;
  TimeOfDay _startTime;
  TimeOfDay _endTime;
  DateTime _startDate;
  DateTime _endDate;
  List<int> includedProducts = [];

  List products = [];
  List<bool> checkBox = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String formatTime(String time) {
    var timeOfDay = time.split(' ')[0];
    var amOrPM = time.split(' ')[1];

    if (amOrPM == 'PM') {
      var hour = timeOfDay.split(':')[0];
      var minutes = timeOfDay.split(':')[1];
      var newHours = int.parse(hour) + 12;
      return [newHours.toString(), minutes].join(':');
    }
    return timeOfDay;
  }

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
    if (_formKey.currentState.validate()) {
      var query = MutationQuery();
      var client = GraphQLConfiguration().clientToQuery();

      var result = await client.query(QueryOptions(
          document: gql(query.updateCustomDiscount(
            widget.id,
              _description,
              _percentage,
              includedProducts,
              formatTime(_startTime.format(context)),
              formatTime(_endTime.format(context)),
              _startDate,
              _endDate))));
      if (!result.hasException) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DiscountPage()));
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

    return result.data['getProducts'];
  }

  void setStartDate(DateTime dateTime) {
    setState(() {
      _startDate = dateTime;
    });
  }

  void setEndDate(DateTime dateTime) {
    setState(() {
      _endDate = dateTime;
    });
  }

  void setStartTime(TimeOfDay time) {
    setState(() {
      _startTime = time;
    });
  }

  void setEndTime(TimeOfDay time) {
    setState(() {
      _endTime = time;
    });
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
                        onChanged: (value) {
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
                          onChanged: (value) => _percentage = int.parse(value),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              labelText: "Percentage")),
                    ),
                  ),
                  TimeAndDate(
                    setEndDate: setEndDate,
                    setStartDate: setStartDate,
                    setEndtime: setEndTime,
                    setStartTime: setStartTime,
                  ),
                ],
              );
            }),
      ),
      persistentFooterButtons: [
        FloatingActionButton.extended(
            icon: Icon(Icons.check_box_outlined),
            label: Text("Create Generic Discount",
                style: TextStyle(fontFamily: "Montserrat Bold")),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditGenericDiscount()));
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
