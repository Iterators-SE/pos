import 'package:flutter/material.dart';

import '../../../../../models/product.dart';
import 'detailed_view_widget.dart';
import 'generic_view_widget.dart';
import 'toggle_view_widget.dart';

class ModeView extends StatefulWidget {
  final List<Product> products;

  const ModeView({Key key, this.products}) : super(key: key);

  @override
  _ModeViewState createState() => _ModeViewState();
}

class _ModeViewState extends State<ModeView> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleViewWidget(
                  isSelected: isSelected,
                  icons: const [
                  Icon(Icons.table_chart , semanticLabel: 'Generic View'),
                  Icon(Icons.list_alt_outlined, semanticLabel: 'Detailed View'),
                  ],
                  onPressed: (index) {
                    setState(() {
                      isSelected = isSelected.map((e) => e == false).toList();
                      isSelected[index] = true;
                    });
                  },
                )
              ],
            ),
            isSelected.first
                ? GenericViewWidget(products: widget.products)
                : DetailedViewWidget(products: widget.products)
          ],
        ),
      ),
    );
  }
}
