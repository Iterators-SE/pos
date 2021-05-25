import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../repositories/discount/discount_repository.dart';
import '../add/discount_add_generic.dart';
import '../details/discount_details.dart';
import '../presenter/discount_screen_presenter.dart';
import '../view/add_discount_screen_view.dart';
import '../view/discount_screen_view.dart';
import '../view/edit_discount_screen_view.dart';
import 'widgets/title.dart';

class DiscountScreen extends StatefulWidget {
  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen>
    implements DiscountScreenView {
  DiscountScreenPresenter _presenter;

  @override
  AppState state;

  @override
  List<Discount> discounts = [];

  @override
  AddDiscountScreenView addDiscountScreenView;

  @override
  EditDiscountScreenView editDiscountScreenView;

  @override
  void initState() {
    _presenter = DiscountScreenPresenter();
    _presenter.view = this;

    state = AppState.loading;
    // addDiscountScreenView = AddDiscountScreen();
    // editDiscountScreenView = EditDiscountScreen();

    getDiscounts().then((value) => {discounts = value});

    super.initState();
  }

  @override
  void onError() {}

  @override
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

  // ignore: missing_return
  Future<List<Discount>> getDiscounts() async {
    var discounts =
        await Provider.of<DiscountRepository>(context, listen: false)
            .getDiscounts();

    var result = discounts.fold((failure) => failure, (list) => list);

    if (discounts.isRight) {
      setState(() {
        this.discounts = result;
        state = AppState.loaded;
      });
    } else {
      setState(() {
        state = AppState.error;
      });
    }
    // var prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('POS_TOKEN');
    // GraphQLConfiguration.setToken(token);
    // var query = MutationQuery();
    // var client = GraphQLConfiguration().clientToQuery();

    // var result = await client.query(
    //   QueryOptions(document: gql(query.getDiscounts())),
    // );
    // return result.data['getDiscounts'];
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
        label: Text(
          "ADD",
          style: TextStyle(fontFamily: "Montserrat Bold"),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGenericDiscount(),
            ),
          );
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
                                  id: int.parse(snapshot.data[index]['id']),
                                ),
                              ),
                            );
                          },
                          child: discountTitles(
                            snapshot.data[index]['description'],
                          ),
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
