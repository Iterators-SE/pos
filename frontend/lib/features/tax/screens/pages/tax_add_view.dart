import 'package:flutter/material.dart';
import '../../models/new_tax.dart';

class AddTaxPage extends StatefulWidget {
  final Function onSubmit;
  const AddTaxPage({Key key, this.onSubmit}) : super(key: key);

  @override
  _AddTaxPageState createState() => _AddTaxPageState();
}

class _AddTaxPageState extends State<AddTaxPage> {
  final _formKey = GlobalKey<FormState>();

  NewTax tax = NewTax(name: "", percentage: 0);

  Widget buildTaxName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '  Tax Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Tax name is required';
        }
        return null;
      },
      onSaved: (value) {
        tax.name = value;
      },
    );
  }

  Widget buildTaxPercentage() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Percentage (without "%", eg. 12)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null) {
          return null;
        }

        final n = double.tryParse(value);

        if (n == null) {
          return 'Enter a valid tax percentage!';
        }

        if (n > 99) {
          return 'Enter a valid tax percentage!';
        }
        return null;
      },
      onSaved: (value) {
        tax.percentage = double.parse(value) / 100;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTaxName(),
                  SizedBox(
                    height: 25,
                  ),
                  buildTaxPercentage(),
                  SizedBox(
                    height: 25,
                  ),
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
                      widget.onSubmit(context, tax);
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
