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

    // TODO: SEE SCAFFOLD MSSG BAR
    if (result.isRight) {
      Navigator.pop(context);
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
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          title(widget.discount.description),
          // subtitle("Product: "),
          // details(widget.discount.description),
          subtitle("Promo Duration:"),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: xposGreen[500]),
            ),
            child: duration(), // TODO: KRISTIAN, EDIT TO REFLECT REAL DATA
          ),
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
