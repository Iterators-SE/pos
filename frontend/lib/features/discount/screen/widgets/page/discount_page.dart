import 'package:flutter/material.dart';
import '../../../../../models/discounts.dart';
import '../title.dart';
import 'discount_details.dart';

class DiscountPage extends StatelessWidget {
  final List<Discount> discounts;

  const DiscountPage({Key key, this.discounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: GridView.builder(
          itemCount: discounts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.landscape
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
                      builder: (context) =>
                          DiscountDetails(discount: discounts[index]),
                    ),
                  );
                },
                child: discountTitles(
                  discounts[index].description,
                ),
              ),
            );
          }),
    );
  }
}
