import 'package:flutter/material.dart';

import '../../../core/ui/styled_text_button.dart';
import '../../../models/product.dart';

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
      title: Text("Add a Product"),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Products"),
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
            Text("Variant"),
            DropdownButtonFormField(
              value: chosenVariant,
              items: chosenProduct?.variants
                      ?.map(
                        (e) => DropdownMenuItem(
                          child: Text(e.variant),
                          value: e.variant,
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
            Text("Quantity", textAlign: TextAlign.start),
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
                            (element) => element.variant == chosenVariant)
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
        StyledTextButton(
          text: "Add Product",
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              var variant = chosenProduct.variants.firstWhere(
                (element) => element.variant == chosenVariant,
              );

              var newVariant = variant.copyWith(quantity: quantity);

              widget.onPressed()(newVariant);

              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
