import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  bool _isTaxable = false;

  dynamic addProduct() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.mutate(MutationOptions(
        document: gql(query.addProducts(
            _productName, _description, _isTaxable, _photoURL))));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildProductName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Name'),
      maxLength: 10,
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
      maxLines: 2,
      decoration: InputDecoration(labelText: 'Description'),
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

  Widget _builURL() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Photo URL'),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value.isEmpty) {
          return 'URL is Required';
        }

        return null;
      },
      onSaved: (value) {
        _photoURL = value;
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
                _builURL(),
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
                    print(_photoURL);
                    print(_isTaxable);

                    addProduct();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InventoryList()
                      ),
                      (route) => false
                    );
                    //Send to API
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
