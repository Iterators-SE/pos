import 'package:flutter/material.dart';

import '../../../../models/product.dart';
import '../widgets/product_tile.dart';

class ProductListPage extends StatefulWidget {
  final Function functionOnTap;
  final List<dynamic> products;
  final bool isSearching;
  final String productToSearch;

  const ProductListPage(
      {Key key,
      this.products,
      this.isSearching,
      this.productToSearch,
      this.functionOnTap})
      : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSearching) {
      var filteredProducts = widget.products.where((element) {
        return element.name
            .toLowerCase()
            .contains(widget.productToSearch.toLowerCase());
      }).toList();
      return Container(
        child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (contex, index) {
              return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: ProductListTile(
                  product: filteredProducts[index],
                  functionOnTap: widget.functionOnTap));
            }),
      );
    }
    return Container(
      child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (contex, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child:ProductListTile(
                product: widget.products[index],
                functionOnTap: widget.functionOnTap)
            );
          }),
    );
  }
}
