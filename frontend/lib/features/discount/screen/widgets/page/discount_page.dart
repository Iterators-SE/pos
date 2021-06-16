import 'package:flutter/material.dart';
import '../../../../../core/themes/config.dart';

import '../../../../../models/discounts.dart';
import '../../../../../models/product.dart';
import '../title.dart';
import 'discount_details.dart';

class DiscountPage extends StatelessWidget {
  final List<Discount> discounts;
  final List<Product> allProducts;

  const DiscountPage({
    Key key,
    this.discounts,
    this.allProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
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
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: xposGreen[300],
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiscountDetails(
                        discount: discounts[index],
                        discounts: discounts,
                        allProducts: allProducts,
                      ),
                    ),
                  );
                },
                child: discountTitles(discounts[index].description),
              ),
            );
          }),
    );
  }
}
