import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../listview/inventory_list.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _productName;
  String _description;
  String _photoURL;
  PickedFile _imageFile;

  int _quantity;
  num _price;

  bool _isTaxable = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    if (_imageFile != null) {
      return Image.network(_imageFile.path);
    }

    return Text("An image has not been selected yet.");
  }

  dynamic _addProduct() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    String link = await uploadFile(_imageFile);

    print(link);

    var addProductResult = await client.mutate(MutationOptions(
        document: gql(query.addProducts(
            _productName, _description, _isTaxable, _photoURL))));

    if (addProductResult.data['addProduct'] != null) {
      await client.mutate(MutationOptions(
          document: gql(query.addVariant("Regular", _quantity, _price,
              addProductResult.data['addProduct']))));

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
          borderRadius: BorderRadius.circular(30), 
        )
      ),
      maxLength: 25,
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
          borderRadius: BorderRadius.circular(30), 
        )
      ),
      maxLines: 2,
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

  Widget _buildQuantityPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder( 
              borderRadius: BorderRadius.circular(30), 
            )
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Name is Required';
            }
            return null;
          },
          onSaved: (value) {
            _name = value;
          },
        
        )
        ),
        SizedBox(
          width: 15.0,
        ),
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder( 
              borderRadius: BorderRadius.circular(30), 
            )
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
            onSaved: (value) {
              _quantity = int.parse(value);
            },
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder( 
                borderRadius: BorderRadius.circular(30), 
            )
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return null;
              }
              final n = num.tryParse(value);
              if (n == null) {
                return 'Enter a price!';
              }
              return null;
            },
            onSaved: (value) {
              _price = num.parse(value);
            },
          ),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildProductName(),
                _buildDescription(),
                _buildQuantityPrice(),
                SizedBox(height: 25),
                ElevatedButton(
                    onPressed: getImage, child: Text("Select an image")),
                SizedBox(height: 10),
                _renderImage(),
                SizedBox(height: 25),
                _buildCheckBox(),
                SizedBox(height: 100),
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
