import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../add/discount_add_generic.dart';
import '../details/discount_details.dart';
import '../reusable_widgets/title.dart';

class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  // DiscountRepository _discountRepository;

  dynamic getDiscounts() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('POS_TOKEN');
    GraphQLConfiguration.setToken(token);
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.query(
      QueryOptions(document: gql(query.getDiscounts())),
    );
    return result.data['getDiscounts'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discounts",
          style: TextStyle(fontFamily: "Montserrat Bold"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("ADD", style: TextStyle(fontFamily: "Montserrat Bold")),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddGenericDiscount()));
        },
      ),
      body: FutureBuilder(
          future: getDiscounts(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 3
                          : 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DiscountDetails(
                                        id: int.parse(
                                            snapshot.data[index]['id']))));
                          },
                          child: discountTitles(
                              snapshot.data[index]['description']),
                        ),
                      );
                    }),
              );
            }
            return Text('No discounts found');
          }),
    );
  }
}
