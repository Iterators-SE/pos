import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/screens/widgets/variant_box.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_variant.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  ProductDetailPage({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  dynamic showVariant() {
    return Container(
      width: 350,
      child: Column(
          children: widget.product.variants.map((value) {
        print(value.variantName);
        return VariantBox(
          name: value.variantName,
          price: value.price,
          quantity: value.quantity,
        );
      }).toList()),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Widget isTaxable(bool taxable) {
    if (taxable) {
      return Text(
        "Taxes apply to this product",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
      );
    }
    return Text(
      "Taxes do not apply to this product",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            
            children: [

              FadeInImage.assetNetwork(
                height: 250,
                width: 800,
                fit: BoxFit.fitWidth,
                placeholder:'assets/images/loading.gif', 
                image: widget.product.photoLink,
              ),
              
              // Image.network(
              //   widget.product.photoLink,
              //   fit: BoxFit.fitWidth,
              //   height: 250,
              //   width: 800,
              //   loadingBuilder: (context, child, loadingProgress) {
              //     if (loadingProgress == null) return child;
              //     return Center(
              //       child: CircularProgressIndicator(
              //         value: loadingProgress.expectedTotalBytes != null
              //             ? loadingProgress.cumulativeBytesLoaded /
              //                 loadingProgress.expectedTotalBytes
              //             : null,
              //       ),
              //     );
              //   },
              // ),
              SizedBox(height: 20),
              Container(
                width: 350,
                child: TextFormField(
                  readOnly: true,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  initialValue: widget.product.name,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: 350,
                child: TextFormField(
                  readOnly: true,
                  minLines: 1,
                  maxLines: 5,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  initialValue: widget.product.description,
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              isTaxable(widget.product.isTaxable),
              SizedBox(height: 20),
              Text(
                "Variants",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              showVariant(),
            ],
          ),
        ),
    );
  }
}
