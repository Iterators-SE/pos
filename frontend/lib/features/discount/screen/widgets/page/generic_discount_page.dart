import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../../../../../models/discounts.dart';
import '../../../../../models/product.dart';
import '../../../../../repositories/discount/discount_repository_implementation.dart';
import '../custom_discount_fab.dart';
import '../subtitle.dart';
import '../title.dart';

class GenericDiscountPage extends StatefulWidget {
  // final GlobalKey<FormState> formKey;
  final Discount discount;
  final Function onSave;
  final Function onPressed;
  final String label;
  final IconData iconLabel;
  final List<Product> products;
  final List<Discount> discounts;

  const GenericDiscountPage({
    Key key,
    @required this.onSave,
    @required this.onPressed,
    @required this.label,
    @required this.iconLabel,
    @required this.products,
    @required this.discounts,
    @required this.discount,
  }) : super(key: key);

  @override
  _GenericDiscountPageState createState() => _GenericDiscountPageState();
}

class _GenericDiscountPageState extends State<GenericDiscountPage> {
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String _description;
  // ignore: unused_field
  int _percentage;

  List<Product> products = [];

  List<int> includedProducts = [];
  List<bool> checkbox = [];

  @override
  void initState() {
    products = widget.products ?? [];
    includedProducts = widget.discount?.products ?? [];

    for (var i = 0; i < products.length; i++) {
      if (widget.discount != null) {
        checkbox.add(widget.discount.products.contains(i));
      } else {
        checkbox.add(false);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 20),
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            title("Discount"),
            subtitle("Name: "),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                initialValue: widget.discount != null
                    ? widget.discount.description
                    : null,
                validator: (value) =>
                    value.isEmpty ? "Please enter description" : null,
                onChanged: (value) => setState(() => _description = value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: "Discount Name",
                ),
              ),
            ),
            subtitle("Product:"),
            ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: includedProducts.contains(products[index].id),
                    onChanged: (value) {
                      setState(() {
                        checkbox[index] = value;
                        if (checkbox[index] == false) {
                          if (includedProducts.contains(products[index].id)) {
                            includedProducts.remove(products[index].id);
                          }
                        } else {
                          includedProducts.add(products[index].id);
                        }
                      });
                    },
                    title: Text(products[index].name),
                  );
                }),
            subtitle("Discount Percentage:"),
            Container(
              padding: EdgeInsets.only(right: 200),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                child: TextFormField(
                  initialValue: widget.discount != null
                      ? widget.discount.percentage.toString()
                      : null,
                  validator: (value) =>
                      value.isEmpty ? 'Please enter percentage' : null,
                  onChanged: (value) => setState(
                    () => _percentage = int.parse(value),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    labelText: "Percentage",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        // CustomDiscountFAB(
        //   onPressed: widget.onPressed,
        //   label: widget.label,
        //   icon: widget.iconLabel,
        // ),
        CustomDiscountFAB(
          onPressed: () async {
            if (_formKey.currentState.validate() &&
                await Provider.of<DiscountRepository>(context, listen: false)
                    .network
                    .isConnected()) {
              widget.onSave(
                description: _description,
                includedProducts: includedProducts,
                percentage: _percentage,
              );
            }
          },
          label: "SAVE",
          icon: Icons.save,
        ),
      ],
    );
  }
}
