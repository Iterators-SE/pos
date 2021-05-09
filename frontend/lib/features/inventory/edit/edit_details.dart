import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql/client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../graphql/graphql_config.dart';
import '../../../graphql/queries.dart';
import '../listview/inventory_list.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _photoURL = widget.productData['photolink'];
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
      return Image.network(widget.productData['photolink']);
    }

    return Image.network(_imageFile.path);
  }

  dynamic handleEdit() async {
    var query = MutationQuery();
    var client = GraphQLConfiguration().clientToQuery();

    if (_imageFile != null) {
      await uploadFile(_imageFile);
    }

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

   Widget _buildProductName() {
    return TextFormField(
      initialValue: widget.productData['productname'],
      decoration: InputDecoration(
        labelText: 'Product Name',
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(30), 
        )
      ),
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
      decoration: InputDecoration(
        labelText: '  Description',
        border: OutlineInputBorder( 
          borderRadius: BorderRadius.circular(30), 
        )
      ),
      minLines: 1,
      maxLines: 3,
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
                Text('Variants', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 15,
                  )
                ),                
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
