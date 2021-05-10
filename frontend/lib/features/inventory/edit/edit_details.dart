import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql/client.dart';
import 'package:image_picker/image_picker.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../listview/inventory_list.dart';
import '../widgets/loading.dart';
import 'model/variants.dart';

class EditDetails extends StatefulWidget {
  final Map productData;

  EditDetails({Key key, @required this.productData}) : super(key: key);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  String _productName;
  String _description;
  String _photoURL;
  //String _name;
  //int _quantity;
  //num _price;
  bool _isTaxable = true;
  PickedFile _imageFile;

  List deletedVariants = [];
  List addedVariants = [];
  List updatedVariants = [];

  String addVariantName;
  int addVariantPrice;
  int addVariantQuantity;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.productData['variants'].length; i++) {
      setState(() {
        updatedVariants.add(
          Variant(
            name: widget.productData['variants'][i]['variantname'],
            price: widget.productData['variants'][i]['price'],
            quantity: widget.productData['variants'][i]['quantity'],
            id: int.parse(widget.productData['variants'][i]['variantid']),
          ),
        );
      });
    }
    print(widget.productData['variants'][0]);
    _photoURL = widget.productData['product']['photolink'];
    print(updatedVariants[0].name);
  }

  void getImage() async {
    var file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = file;
    });
  }

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
    if (_imageFile == null) {
      return Image.network(widget.productData['product']['photolink']);
    }

    return Image.network(_imageFile.path);
  }

  dynamic handleEdit() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();
    var variantUpdateResult;
    var productUpdateResult;

    if (_imageFile != null) {
      await uploadFile(_imageFile);
    }

    productUpdateResult = await client.mutate(MutationOptions(
        document: gql(query.editProductDetails(
            int.parse(widget.productData['product']['id']),
            _productName,
            _description,
            _isTaxable, // for istaxable value bug
            _photoURL))));

    if (productUpdateResult.data['changeProductDetails']) {
      for (var i = 0; i < deletedVariants.length; i++) {
        variantUpdateResult = await client.mutate(MutationOptions(
          document: gql(query.deleteVariant(deletedVariants[i].id)),
        ));
      }

      for (var i = 0; i < addedVariants.length; i++) {
      }

      for (var i = 0; i < updatedVariants.length; i++) {
        variantUpdateResult = await client.mutate(MutationOptions(
          document: gql(
            query.editVariant(
              updatedVariants[i].name,
              updatedVariants[i].quantity,
              updatedVariants[i].price,
              updatedVariants[i].id,
            ),
          ),
        ));
      }

      // for (var i = 0; i < updatedVariants.length; i++) {
      //   print(updatedVariants[i].name);
      //   print(updatedVariants[i].price);
      //   print(updatedVariants[i].quantity);
      //   print("");
      //   print("");
      // }
      if (await variantUpdateResult.data['editVariant']) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => InventoryList()),
            (route) => false);
      }
    }
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

  Widget _buildProductName() {
    return TextFormField(
      initialValue: widget.productData['product']['productname'],
      decoration: InputDecoration(
          labelText: 'Product Name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
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
      initialValue: widget.productData['product']['description'],
      decoration: InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      minLines: 1,
      maxLines: 5,
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

  dynamic showVariant() {
    var widgets = <Widget>[];

    widgets.add(
      Text(
        'Old Variants',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
    widgets.add(
      SizedBox(
        height: 10,
      ),
    );

    if (updatedVariants.isEmpty) {
      widgets.add(
        Text(
          'No variants.',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
        ),
      );
    }

    for (var i = 0; i < updatedVariants.length; i++) {
      widgets.add(
        variantBox(updatedVariants[i], false),
      );
    }

    widgets.add(
      SizedBox(
        height: 20,
      ),
    );

    widgets.add(
      Text(
        'New Variants',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );

    widgets.add(
      SizedBox(
        height: 10,
      ),
    );

    if (addedVariants.isEmpty) {
      widgets.add(
        Text(
          'No variants.',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
        ),
      );
    }

    for (var i = 0; i < addedVariants.length; i++) {
      widgets.add(
        variantBox(addedVariants[i], true),
      );
    }

    return Container(
      width: 350,
      child: Column(children: widgets),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Widget variantBox(Variant variant, bool isAdded) {
    print(isAdded);
    if (isAdded) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  readOnly: true,
                  initialValue: '${variant.name}',
                  decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: TextFormField(
                  readOnly: true,
                  initialValue: '${variant.quantity}',
                  decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: TextFormField(
                  readOnly: true,
                  initialValue: '${variant.price}',
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
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
                    deletedVariants.add(variant);
                    addedVariants
                        .removeWhere((element) => element.name == variant.name);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: TextFormField(
                readOnly: false,
                onChanged: (value) {
                  var index = updatedVariants
                      .indexWhere((element) => element.id == variant.id);
                  print(updatedVariants[index].name);
                  updatedVariants[index].name = value;
                },
                initialValue: '${variant.name}',
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: TextFormField(
                readOnly: false,
                onChanged: (value) {
                  var index = updatedVariants
                      .indexWhere((element) => element.id == variant.id);
                  print(updatedVariants[index].quantity);
                  updatedVariants[index].quantity = int.parse(value);
                },
                initialValue: '${variant.quantity}',
                decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Flexible(
              child: TextFormField(
                readOnly: false,
                onChanged: (value) {
                  var index = updatedVariants
                      .indexWhere((element) => element.id == variant.id);
                  print(updatedVariants[index].price);
                  updatedVariants[index].price = int.parse(value);
                },
                initialValue: '${variant.price}',
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
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
                  deletedVariants.add(variant);
                  updatedVariants
                      .removeWhere((element) => element.id == variant.id);
                });
              },
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
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
                            borderRadius: BorderRadius.circular(30),
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
                            borderRadius: BorderRadius.circular(30),
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
                            borderRadius: BorderRadius.circular(30),
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
                                addedVariants.add(
                                  Variant(
                                      name: addVariantName,
                                      price: addVariantPrice,
                                      quantity: addVariantQuantity),
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
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product Details")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25),
                ElevatedButton(
                    onPressed: getImage, child: Text("Change Image")),
                SizedBox(height: 25),
                _renderImage(),
                SizedBox(height: 10),
                _buildProductName(),
                SizedBox(height: 10),
                _buildDescription(),
                SizedBox(height: 10),
                _buildCheckBox(),
                SizedBox(height: 15),
                Text(
                  'Variants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 25),
                showVariant(),
                ElevatedButton(onPressed: alertDialog, child: Text("Add")),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text(
                    'Save Changes',
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    print(_productName);
                    print(_description);
                    print(_photoURL);
                    print(_isTaxable);
                    loading();
                    handleEdit();
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
