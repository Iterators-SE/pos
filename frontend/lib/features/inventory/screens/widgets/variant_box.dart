import 'package:flutter/material.dart';

class VariantBox extends StatelessWidget {
  final String name;
  final int quantity;
  final int price;

  const VariantBox({Key key, this.quantity, this.price, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                readOnly: true,
                initialValue: '$name',
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: TextFormField(
                readOnly: true,
                initialValue: '$quantity',
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: TextFormField(
                readOnly: true,
                initialValue: '$price',
                decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ]
    );
  }
}