import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/config.dart';
import '../../../../../models/discounts.dart';
import '../../../../../models/product.dart';
import '../../../../../repositories/discount/discount_repository_implementation.dart';
import '../../generic_discount_screen.dart';
import '../custom_discount_fab.dart';
import '../duration.dart';
import '../duration_container.dart';
import '../subtitle.dart';
import '../title.dart';

class DiscountDetails extends StatefulWidget {
  final Discount discount;
  final List<Discount> discounts;
  final List<Product> allProducts;

  const DiscountDetails({
    @required this.discount,
    @required this.discounts,
    @required this.allProducts,
  });

  @override
  _DiscountDetailsState createState() => _DiscountDetailsState();
}

class _DiscountDetailsState extends State<DiscountDetails> {
  void deleteDiscount() async {
    var result = await Provider.of<DiscountRepository>(context, listen: false)
        .deleteDiscount(
      id: widget.discount.id,
    );

    if (result.isRight) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.discount.description} successfully deleted!'),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not delete ${widget.discount.description}.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('widget.discount');
    print(widget.discount);
    print(widget.discount.description);
    print(widget.discount.percentage);
    print(widget.discount.id);
    print(widget.discount);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Discounts",
        style: TextStyle(fontFamily: "Montserrat Bold"),
      )),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          title(widget.discount.description),
          ...widget.discount?.endTime != null
              ? [
                  subtitle("Promo Duration:"),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: xposGreen[500]),
                    ),
                    child:
                        duration(), // TODO: KRISTIAN, EDIT TO REFLECT REAL DATA
                  ),
                ]
              : [],
          ...widget.discount != null
              ? [
                  subtitle("Included Products:"),
                  ...widget.discount.products.map((e) {
                    var product = widget.allProducts
                        .firstWhere((element) => element.id == e, orElse: null);

                    if (product != null) {
                      return CheckboxListTile(
                        value: true,
                        onChanged: null,
                        title: Text(product.name),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }).toList()
                ]
              : [],
          subtitle("Discount Percent:"),
          durationContainer("${widget.discount.percentage}%")
        ],
      ),
      persistentFooterButtons: [
        CustomDiscountFAB(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenericDiscountScreen(
                isAdd: false,
                discounts: widget.discounts,
                discount: widget.discount,
                allProducts: widget.allProducts,
              ),
            ),
          ),
          label: "EDIT",
          icon: Icons.edit,
        ),
        CustomDiscountFAB(
          onPressed: deleteDiscount,
          label: "DELETE",
          icon: Icons.delete_forever,
        ),
      ],
    );
  }
}
