import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../models/product.dart';

class TopProductWidget extends StatelessWidget {
  final Product product;
  final Function onPressed;

  const TopProductWidget({
    Key key,
    @required this.product,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        //mainAxisSize: MainAxisSize.,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5, left: 20),
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(5.0, 8.0),
                  blurRadius: 7.0,
                  spreadRadius: 1.50)
                ],
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  product.photoLink ??
                      'https://cf.shopee.ph/file/6907c52b5698df501bf2fd83e803d6d2',
                ),
              ),
            ),
          ),
          Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.name ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
