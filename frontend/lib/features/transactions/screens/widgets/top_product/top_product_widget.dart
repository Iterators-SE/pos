import 'package:flutter/material.dart';
import '../../../../../models/product.dart';

class TopProductWidget extends StatelessWidget {
  final Product product;

  const TopProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                // TODO: Replace with product image && ask Alan about the model.
                  'https://cf.shopee.ph/file/6907c52b5698df501bf2fd83e803d6d2'),
            ),
          ),
        ),
        FractionalTranslation(
          translation: Offset(0, -0.5),
          child: Container(
            width: 160,
            height: 70,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                   textAlign: TextAlign.center,
                   maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 5, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
