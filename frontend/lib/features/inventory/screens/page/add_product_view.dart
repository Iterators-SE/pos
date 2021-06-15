import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/new_product.dart';
import '../../models/new_variant.dart';
import '../widgets/variant_box.dart';

class AddProductPage extends StatefulWidget {
  final Function onSubmit;

  const AddProductPage({Key key, this.onSubmit}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  NewProduct product =
      NewProduct(description: "", name: "", isTaxable: true, photoLink: "");

  NewVariant variant = NewVariant(name: "", price: 0, quantity: 0);

  PickedFile imageFile;

  void getImage() async {
    var file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = file;
    });
  }

  Widget renderImage() {
    if (imageFile != null) {
      if (kIsWeb) {
        return Image.network(imageFile.path);
      } else {
        return Semantics(
            child: Image.file(File(imageFile.path)),
            label: 'image_picker_example_picked_image');
      }
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget buildProductName() {
    return TextFormField(
      key: Key("productName"),
      decoration: InputDecoration(
        labelText: '  Product Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Product Name is Required';
        }
        return null;
      },
      onSaved: (value) {
        product.name = value;
      },
    );
  }

  Widget buildDescription() {
    return TextFormField(
      key: Key("productDescription"),
      decoration: InputDecoration(
          labelText: '  Description',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      maxLength: 80,
      validator: (value) {
        if (value.isEmpty) {
          return 'Description is Required';
        }
        return null;
      },
      onSaved: (value) {
        product.description = value;
      },
    );
  }

  Widget buildCheckBox() {
    return CheckboxListTile(
        value: product.isTaxable,
        title: Text("Apply tax to this product."),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          setState(() {
            if (product.isTaxable) {
              product.isTaxable = false;
            } else {
              product.isTaxable = true;
            }
          });
        });
  }

  Future<void> variantForm() async {
    var _variantKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          key: Key("variantDialog"),
          insetPadding: EdgeInsets.all(5),
          title: Center(child: Text('Add a variant')),
          content: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _variantKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      key: Key("variantName"),
                      decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name is Required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          variant.name = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      key: Key("variantQuantity"),
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) {
                          return null;
                        }
                        final n = int.tryParse(value);
                        if (n == null) {
                          return 'Enter a valid whole number!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          variant.quantity = int.parse(value);
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      key: Key("variantPrice"),
                      decoration: InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) {
                          return null;
                        }
                        final n = int.tryParse(value);
                        if (n == null) {
                          return 'Enter a price!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          variant.price = int.parse(value);
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text('Confirm'),
                            onPressed: () {
                              if (!_variantKey.currentState.validate()) {
                                return;
                              }

                              print(product.variants);
                              _variantKey.currentState.save();
                              setState(() {
                                product.addVariant(variant);
                                variant = NewVariant(
                                  name: "",
                                  price: 0,
                                  quantity: 0,
                                );
                              });

                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: Text('cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget variantAddDelete() {
    if (product.variants.isEmpty) {
      return ElevatedButton(onPressed: variantForm, child: Text("Add"));
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: variantForm, child: Text("Add")),
          SizedBox(width: 5),
          ElevatedButton(
            onPressed: () {
              setState(() {
                product.deleteVariant();
              });
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  Widget showVariant() {
    return Column(
        children: product.variants.map((value) {
      print(value.name);
      return VariantBox(
        name: value.name,
        price: value.price,
        quantity: value.quantity,
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25),
              ElevatedButton(
                  onPressed: getImage, child: Text("Select an image")),
              SizedBox(height: 10),
              renderImage(),
              SizedBox(height: 25),
              buildProductName(),
              SizedBox(height: 10),
              buildDescription(),
              SizedBox(height: 25),
              Text('Variants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
              SizedBox(height: 10),
              showVariant(),
              variantAddDelete(),
              SizedBox(height: 20),
              buildCheckBox(),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(product.name);
                  print(product.description);
                  print(product.isTaxable);
                  print(product.isTaxable);
                  widget.onSubmit(
                      imageFile: imageFile, product: product, context: context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
