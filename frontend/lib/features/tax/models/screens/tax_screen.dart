import 'package:flutter/material.dart';
import 'add_tax.dart';

class TaxScreen extends StatefulWidget {
  @override
  _TaxScreenState createState() => _TaxScreenState();
}

class _TaxScreenState extends State<TaxScreen>{
  bool _value = false;
  bool _valu = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Tax')      
    ),
    floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add"),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTaxScreen()));
           
        },     
      ),
    body: Center(
    child: Container(
      margin: EdgeInsets.all(20.0),
      width:400 ,
      height: 300,
        child: Column(
        children: <Widget>[
          Text("Selected",
            style: TextStyle(fontSize: 25)
          ),
          TextFormField(
          decoration: InputDecoration(
            labelText: 'Selected Discount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
          )), 
          ),
          SizedBox(
            height: 20,
          ),
          CheckboxListTile(
            title: const Text('Tax 1',
              style: TextStyle(fontSize: 20)
            ),
            subtitle:
                const Text('20%'),
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ), //CheckboxListTile
        CheckboxListTile(
            title: const Text('Tax 2',
              style: TextStyle(fontSize: 20)
            ),
            subtitle: const Text(
                '15%'),
            selected: _valu,
            value: _valu,
            onChanged: (value) {
              setState(() {
                _valu = value;
              });
            },
          ), 
        CheckboxListTile(
            title: const Text('Tax 3',
              style: TextStyle(fontSize: 20)
            ),
            subtitle: const Text(
                '10%'),
            selected: _valu,
            value: _valu,
            onChanged: (value) {
              setState(() {
                _valu = value;
              });
            },
          ), //Checkbox//CheckboxListTile
        ]
      ))

    ));
}}
