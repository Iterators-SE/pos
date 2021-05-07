import 'package:flutter/material.dart';
import 'package:frontend/core/themes/config.dart';
import 'package:frontend/features/discount/edit/discount_edit.dart';
import 'package:frontend/features/discount/dicount_page/discountpage.dart';
import 'package:frontend/features/discount/reusable_widgets/formfield.dart';
import 'package:frontend/features/discount/reusable_widgets/subtitle.dart';
import 'package:frontend/features/discount/reusable_widgets/time_date.dart';
import '../reusable_widgets/title.dart';

class DiscountDetails extends StatefulWidget {
  @override
  _DiscountDetailsState createState() => _DiscountDetailsState();
}

class _DiscountDetailsState extends State<DiscountDetails> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discounts",
          style: TextStyle(fontFamily: "Montserrat Bold"),
        )
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          title("PWD DISCOUNT"),
          subtitle("Product:"),
          details("KEYK"),
          subtitle("Time:"),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: xposGreen[500]
              )
            ),
            child: TimeAndDate(),
          ),
          subtitle("Discount percent:"),
          form2()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.check_box_outlined),
        label: Text("EDIT", style: TextStyle(fontFamily: "Montserrat Bold")),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditDiscount()));
        },
      ),
    );
  }
}
