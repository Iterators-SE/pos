import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "../../../core/themes/config.dart";
import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../edit/discount_edit_generic.dart';
import '../screen/discount_screen.dart';
import '../screen/widgets/duration.dart';
import '../screen/widgets/duration_container.dart';
import '../screen/widgets/subtitle.dart';
import '../screen/widgets/title.dart';

class DiscountDetails extends StatefulWidget {
  final int id;
  DiscountDetails({this.id});
  @override
  _DiscountDetailsState createState() => _DiscountDetailsState();
}

class _DiscountDetailsState extends State<DiscountDetails> {
  dynamic getDiscount() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('POS_TOKEN');
    GraphQLConfiguration.setToken(token);
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(document: gql(query.getDiscount(widget.id))),
    );
    print(result);
    return result.data['getDiscount'];
  }

  void deleteDiscount() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('POS_TOKEN');
    GraphQLConfiguration.setToken(token);
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(
        document: gql(
          query.deleteDiscount(widget.id),
        ),
      ),
    );
    print(result);
    if (!result.hasException) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DiscountScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Discounts",
        style: TextStyle(fontFamily: "Montserrat Bold"),
      )),
      body: FutureBuilder(
          future: getDiscount(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              print(snapshot.data['description']);
              return ListView(
                padding: EdgeInsets.only(left: 10, right: 20),
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  title(snapshot.data['description']),
                  subtitle("Product:"),
                  details("KEYK"),
                  subtitle("Promo Duration:"),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: xposGreen[500]),
                    ),
                    child: duration(),
                  ),
                  subtitle("Discount Percent:"),
                  durationContainer("${snapshot.data["percentage"]}%")
                ],
              );
            }
            return Text('Discount is not available');
          }),
      persistentFooterButtons: [
        FloatingActionButton.extended(
          icon: Icon(Icons.edit),
          label: Text(
            "EDIT",
            style: TextStyle(fontFamily: "Montserrat Bold"),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditGenericDiscount(
                  id: widget.id,
                ),
              ),
            );
          },
        ),
        FloatingActionButton.extended(
          icon: Icon(Icons.edit),
          label: Text(
            "DELETE",
            style: TextStyle(fontFamily: "Montserrat Bold"),
          ),
          onPressed: deleteDiscount,
        ),
      ],
    );
  }
}
