import 'package:flutter/material.dart';
import '../dicount_page/discountpage.dart';
import '../reusable_widgets/formfield.dart';
import '../reusable_widgets/subtitle.dart';
import '../reusable_widgets/time_date.dart';
import '../reusable_widgets/title.dart';
import '/core/themes/config.dart';



class EditDiscount extends StatefulWidget {
  @override
  _EditDiscountState createState() => _EditDiscountState();
}

class _EditDiscountState extends State<EditDiscount> {
  String valueChoose;
  List products = ["Coffee", "Keyk", "Shake"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          title("Discount"),
          subtitle("Name:"),
          form(),
          subtitle("Product:"),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: DropdownButton(
              hint: Text("Select product"),
              isExpanded: true,
              underline: SizedBox(),
              value: valueChoose,
              onChanged: (newValue) {
                setState(() {
                  valueChoose = newValue;
                });
              },
              items: products.map((product) {
                return DropdownMenuItem(
                  child: Text(product),
                  value: product,
                );
              }).toList(),
            ),
              )
          ),
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
        label: Text("SAVE", style: TextStyle(fontFamily: "Montserrat Bold")),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DiscountPage()));
        },
      ),
    );
  }
}
