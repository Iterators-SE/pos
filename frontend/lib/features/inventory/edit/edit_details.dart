import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/listview/inventory_list.dart';
import 'package:graphql/client.dart';

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../details/product_details.dart';

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
  bool _isTaxable = true;

  dynamic handleEdit() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    var result = await client.mutate(MutationOptions(
        document: gql(query.editProductDetails(
            int.parse(widget.productData['id']),
            _productName,
            _description,
            _isTaxable, // for istaxable value bug
            _photoURL))));

    if (result.data['changeProductDetails']) {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             ProductDetails(productData: widget.productData)),
      //     (route) => false);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InventoryList()),
          (route) => false);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildProductName() {
    return TextFormField(
      initialValue: widget.productData['productname'],
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
      initialValue: widget.productData['description'],
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
      initialValue: widget.productData['photolink'],
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
      appBar: AppBar(title: Text("Edit Product Details")),
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
