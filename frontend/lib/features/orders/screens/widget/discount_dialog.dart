import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/themes/config.dart';
import '../../../../models/discounts.dart';

class DiscountDialog extends StatefulWidget {
  final List<Discount> discounts;
  final List<Discount> selectedDiscounts;
  final Function onPressed;

  DiscountDialog({
    Key key,
    @required this.discounts,
    @required this.selectedDiscounts,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _DiscountDialogState createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  List<Discount> discounts;
  List<Discount> selectedDiscounts;
  int quantity;

  @override
  void initState() {
    discounts = widget.discounts;
    selectedDiscounts = widget.selectedDiscounts;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("Select Applicable Discounts"),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.only(right: 5, top: 10),
                alignment: Alignment.center,
                child: Text("Discounts"),
                decoration: BoxDecoration(
                    border: Border.all(color: xposGreen[50]),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              ...discounts
                  .map(
                    (discount) => CheckboxListTile(
                      title: Text(discount.description),
                      value: selectedDiscounts.contains(discount),
                      onChanged: (value) {
                        if (value && !selectedDiscounts.contains(discount)) {
                          setState(() => selectedDiscounts.add(discount));
                        } else if (!value) {
                          setState(() => selectedDiscounts.remove(discount));
                        }
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
      actions: [
        FloatingActionButton.extended(
          label: Text("Apply Discounts"),
          onPressed: () {
              widget.onPressed()(selectedDiscounts);
              Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
