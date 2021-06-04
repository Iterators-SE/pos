import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/screens/page/product_details_view.dart';
import 'package:frontend/features/inventory/screens/product_details_screen.dart';
import '../../../../models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  final Function functionOnTap;

  const ProductListTile({Key key, this.product, this.functionOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      child: Card(
          child: ListTile(
              isThreeLine: true,
              leading: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(product.photoLink),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    product.description,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        product.variants.length == 1
                            ? 'Price: Php ${product.max}'
                            : 'Price: Php ${product.min} - ${product.max}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 25),
                      Text(
                        'Quantity: ${product.quantity}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onTap: () async {
                // print("Stateless Widget");
                // print(product.name);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ProductDetailScreen(
                //               product: product,
                //             )));
                print(product);
                await functionOnTap(product: product, context: context);
              }),
          elevation: 5,
          margin: EdgeInsets.fromLTRB(10, 11, 10, 0)),
    );
  }
}
