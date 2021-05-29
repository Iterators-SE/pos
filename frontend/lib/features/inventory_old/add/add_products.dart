import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../listview/inventory_list.dart';
import '../widgets/loading.dart';
import 'model/variants.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String addVariantName;
  int addVariantQuantity;
  int addVariantPrice;

  String _productName;
  String _description;
  // String _name;
  String _photoURL;
  PickedFile _imageFile;

  List variants = [];

  final int _quantity = 0;
  final int _price = 0;

  bool _isTaxable = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void getImage() async {
    var file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = file;
    });
  }

  // void pushWidget(Widget variantBox){
  //   variants.
  // }

  dynamic uploadFile(PickedFile file) async {
    var dateNow = DateTime.now().millisecondsSinceEpoch.toString();
    var ref = firebase_storage.FirebaseStorage.instance
        .refFromURL('gs://iterators-pos-photo-storage.appspot.com')
        .child('images')
        .child('/$dateNow.jpg');

    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');

    var uploadTask = await ref.putData(await file.readAsBytes(), metadata);
    var url = await uploadTask.ref.getDownloadURL();

    setState(() {
      _photoURL = url;
    });
  }

  Widget _renderImage() {
    if (_imageFile != null) {
      return Image.network(_imageFile.path);
    }

    return Text("An image has not been selected yet.");
  }

  dynamic _addProduct() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();
    var addProductResult;

    String link = await uploadFile(_imageFile);

    print('link');
    print(link);

    addProductResult = await client.mutate(MutationOptions(
        document: gql(query.addProduct(
            _productName, _description, _isTaxable, _photoURL))));

    if (addProductResult.data['addProduct'] != null) {
      if (variants.isEmpty) {
        print("No variants added");
        await client.mutate(MutationOptions(
            document: gql(query.addVariant("Regular", _quantity, _price,
                addProductResult.data['addProduct']))));
      } else {
        print("Have variants added");
        print(variants);
        for (var i = 0; i < variants.length; i++) {
          await client.mutate(MutationOptions(
              document: gql(query.addVariant(
                variants[i].name, 
                variants[i].quantity, 
                variants[i].price,
                addProductResult.data['addProduct']))));
        }
      }

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InventoryList()),
          (route) => false);
    }
  }

  Widget _buildProductName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: '  Product Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Product Name is Required';
        }
        return null;
      },
      onSaved: (value) {
        _productName = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
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
        _description = value;
      },
    );
  }

  Widget _buildCheckBox() {
    return CheckboxListTile(
        value: _isTaxable,
        title: Text("Apply tax to this product."),
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          setState(() {
            if (_isTaxable) {
              _isTaxable = false;
            } else {
              _isTaxable = true;
            }
          });
        });
  }

  Future<void> loading() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return LoadingModal();
      },
    );
  }

  Future<void> variantForm() async {
    var _variantKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(5),
          title: Center(child: Text('Add a variant')),
          content: Container(
            width: 250,
            height: 300,
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
                        addVariantName = value;
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
                        addVariantQuantity = int.parse(value);
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
                        addVariantPrice = int.parse(value);
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
                              variants.add(
                                Variant(
                                    variantName: addVariantName,
                                    variantPrice: addVariantPrice,
                                    variantQuantity: addVariantQuantity),
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
        );
      },
    );
  }

  Widget variantBox(String name, int quantity, int price) {
    return Column(children: [
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
      )
    ]);
  }

  Widget variantAddDelete() {
    if (variants.isEmpty) {
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
                variants.removeLast();
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
        children: variants.map((value) {
      return variantBox(value.name, value.quantity, value.price);
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SingleChildScrollView(
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
                _renderImage(),
                SizedBox(height: 25),
                _buildProductName(),
                SizedBox(height: 10),
                _buildDescription(),
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
                _buildCheckBox(),
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

                    print(_productName);
                    print(_description);
                    print(_isTaxable);
                    loading();
                    _addProduct();
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