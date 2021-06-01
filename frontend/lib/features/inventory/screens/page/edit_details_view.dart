import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/models/edit_new_variant.dart';
import 'package:frontend/features/inventory/models/edit_product_variant.dart';
import 'package:frontend/features/inventory/models/new_variant.dart';
import 'package:frontend/features/inventory/screens/widgets/variant_box.dart';
import 'package:frontend/models/product_variant.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../models/product.dart';

class EditDetailPage extends StatefulWidget {
  final Product product;
  final Function onSubmit;
  EditDetailPage({Key key, this.product, this.onSubmit}) : super(key: key);

  @override
  _EditDetailPageState createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Product product;

  List<EditableProductVariant> oldVariants = [];
  List<NewVariant> addedVariants = [];

  PickedFile imageFile;
  NewVariant newVariant;

  @override
  void initState() {
    product = widget.product;
    print("product");
    print(product);

    for (var i = 0; i < product.variants.length; i++) {
      oldVariants.add(EditableProductVariant(
        index: i,
        oldVariant: widget.product.variants[i],
      ));
    }

    print(oldVariants);

    newVariant = NewVariant(name: "", price: 0, quantity: 0);
    super.initState();
  }

  Future<void> alertDialog() async {
    var _variantKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(5),
          title: Center(child: Text('Add a variant')),
          content: SingleChildScrollView(
              child: Form(
            key: _variantKey,
            child: Column(
              children: <Widget>[
                TextFormField(
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
                    setState(() {
                      newVariant.name = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
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
                      newVariant.quantity = int.parse(value);
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
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
                      newVariant.price = int.parse(value);
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
                          _variantKey.currentState.save();

                          setState(() {
                            addedVariants.add(
                              newVariant,
                            );
                            newVariant =
                                NewVariant(name: "", price: 0, quantity: 0);
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
          )),
        );
      },
    );
  }

  void getImage() async {
    var file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = file;
    });
  }

  Widget renderImage() {
    if (imageFile == null) {
      return Image.network(
        product.photoLink,
        fit: BoxFit.fitWidth,
        height: 250,
        width: 800,
      );
    }

    if (kIsWeb) {
      return Image.network(
        imageFile.path,
        fit: BoxFit.fitWidth,
        height: 250,
        width: 800,
      );
    } else {
      return Image.file(
        File(imageFile.path),
        fit: BoxFit.fitWidth,
        height: 250,
        width: 800,
      );
    }
  }

  List<EditableProductVariant> listOfEditableVariantBoxes() {
    return oldVariants.where((e) => !e.isDeleted).toList();
  }

  Widget showVariants() {
    return Column(
      children: listOfEditableVariantBoxes()
          .map((e) => editableVariantBox(e.oldVariant, e.index))
          .toList(),
    );
  }

  Widget editableVariantBox(ProductVariant variant, int indexOfVariant) {
    var variantsLeft = oldVariants
    .where((element) => !element.isDeleted)
    .toList().length;

    if(variantsLeft < 2){
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    readOnly: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is Required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        oldVariants[indexOfVariant].oldVariant.variantName =
                            value;
                      });
                    },
                    initialValue: '${variant.variantName}',
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: TextFormField(
                    readOnly: false,
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
                      oldVariants[indexOfVariant].oldVariant.quantity =
                          int.parse(value);
                    },
                    initialValue: '${variant.quantity}',
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
                    readOnly: false,
                    onChanged: (value) {
                      oldVariants[indexOfVariant].oldVariant.price =
                          int.parse(value);
                    },
                    initialValue: '${variant.price}',
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      );

    } else {
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    readOnly: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is Required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        oldVariants[indexOfVariant].oldVariant.variantName =
                            value;
                      });
                    },
                    initialValue: '${variant.variantName}',
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: TextFormField(
                    readOnly: false,
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
                      oldVariants[indexOfVariant].oldVariant.quantity =
                          int.parse(value);
                    },
                    initialValue: '${variant.quantity}',
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
                    readOnly: false,
                    onChanged: (value) {
                      oldVariants[indexOfVariant].oldVariant.price =
                          int.parse(value);
                    },
                    initialValue: '${variant.price}',
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      oldVariants[indexOfVariant].isDeleted = true;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }
  }

  Widget showNewVariants() {
    return Column(
        children: addedVariants
            .map((e) => VariantBox(
                  name: e.name,
                  price: e.price,
                  quantity: e.quantity,
                ))
            .toList());
  }

  Widget buildProductName() {
    return TextFormField(
      initialValue: widget.product.name,
      decoration: InputDecoration(
          labelText: 'Product Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Name must not be empty';
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
      initialValue: widget.product.description,
      decoration: InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      // maxLength: 80,
      validator: (value) {
        if (value.isEmpty) {
          return 'Description must not be empty';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                ElevatedButton(
                    onPressed: getImage, child: Text("Change Image")),
                SizedBox(height: 25),
                renderImage(),
                SizedBox(height: 25),
                buildProductName(),
                SizedBox(height: 10),
                buildDescription(),
                SizedBox(height: 10),
                buildCheckBox(),
                SizedBox(height: 15),
                Text(
                  'Variants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 20),
                showVariants(),
                SizedBox(height: 25),
                Text(
                  'New Variants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 20),
                showNewVariants(),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: alertDialog, child: Text("Add")),
                      SizedBox(width: 5),
                      addedVariants.isNotEmpty
                          ? ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                setState(() {
                                  addedVariants.removeLast();
                                });
                              },
                              child: Text("Delete"),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  child: Text(
                    'Save Changes',
                    style: TextStyle(),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();
                    await widget.onSubmit(context, product, imageFile,
                        oldVariants, addedVariants);
                    // print(await oldVariants);
                    // print(await addedVariants);
                    // print(await product);

                    // await widget.onSubmit();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
