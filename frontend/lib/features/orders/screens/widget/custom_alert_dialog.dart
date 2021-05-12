import 'package:flutter/material.dart';
import 'package:frontend/core/themes/config.dart';

//import '../../../../core/ui/styled_text_button.dart';
import '../../../../models/product.dart';

// TODO: Add styling
class CustomAlertDialog extends StatefulWidget {
  final List<Product> allProducts;
  final Function onPressed;
  final Product chosenProduct;
  final String chosenVariant;
  final int quantity;

  CustomAlertDialog({
    Key key,
    this.allProducts,
    this.onPressed,
    this.chosenProduct,
    this.chosenVariant,
    this.quantity,
    chosenvariantName,
  }) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  Product chosenProduct;
  String chosenVariant;
  int quantity;

  @override
  void initState() {
    chosenProduct = widget.chosenProduct;
    chosenVariant = widget.chosenVariant;
    quantity = widget.quantity;

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("Add a Product"),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              margin: EdgeInsets.only(right: 5, top: 10),
              alignment: Alignment.center,
              child: Text("Products"),
              decoration: BoxDecoration(
                  border: Border.all(color: xposGreen[50]),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            DropdownButtonFormField(
              hint: Text("Please select a product"),
              value: chosenProduct?.name,
              items: widget.allProducts
                  .map((e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e.name,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  var _index = widget.allProducts.indexWhere(
                    (element) => element.name == value,
                  );

                  chosenProduct = widget.allProducts[_index];
                  chosenVariant = null;
                });
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              margin: EdgeInsets.only(right: 5, top: 10),
              alignment: Alignment.center,
              child: Text("Variants"),
              decoration: BoxDecoration(
                  border: Border.all(color: xposGreen[50]),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            DropdownButtonFormField(
              value: chosenVariant,
              items: chosenProduct?.variants
                      ?.map(
                        (e) => DropdownMenuItem(
                          child: Text(e.variantName),
                          value: e.variantName,
                        ),
                      )
                      ?.toList() ??
                  [],
              hint: Text("Please select a variant"),
              onChanged: (value) {
                setState(() {
                  chosenVariant = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
              margin: EdgeInsets.only(right: 5, top: 10),
              alignment: Alignment.center,
              child: Text("Quantity"),
              decoration: BoxDecoration(
                  border: Border.all(color: xposGreen[50]),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (value) {
                setState(() {
                  quantity = int.parse(value);
                });
              },
              validator: (value) {
                if (int.tryParse(value.toString()) == null) {
                  return """Invalid entry. Must be a whole number greater than 0.""";
                }

                if (chosenProduct == null) {
                  return "Please select a product first.";
                }

                if (chosenVariant == null) {
                  return "Please select a variant";
                }

                if (chosenProduct.variants
                        .firstWhere(
                            (element) => element.variantName == chosenVariant)
                        .quantity <
                    int.parse(value)) {
                  return "Insufficient stock";
                }

                return null;
              },
              keyboardType: TextInputType.number,
            )
          ],
        ),
      ),
      actions: [
        FloatingActionButton.extended(
          label: Text("Add Product"),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              var variant = chosenProduct.variants.firstWhere(
                (element) => element.variantName == chosenVariant,
              );

              var newVariant = variant.copyWith(quantity: quantity);

              widget.onPressed()(newVariant);

              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
