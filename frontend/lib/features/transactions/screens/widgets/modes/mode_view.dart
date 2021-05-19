import 'package:flutter/material.dart';
import 'package:frontend/features/transactions/screens/widgets/modes/detailed_view_widget.dart';
import 'package:frontend/features/transactions/screens/widgets/modes/generic_view_widget.dart';
import 'package:frontend/features/transactions/screens/widgets/modes/toggle_view_widget.dart';
import 'package:frontend/models/product.dart';

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleViewWidget(
              isSelected: isSelected,
              icons: const [
                Icon(Icons.list, semanticLabel: 'Generic View'),
                Icon(Icons.description, semanticLabel: 'Detailed View'),
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
            : DetailedViewWidget()
      ],
    );
  }
}
