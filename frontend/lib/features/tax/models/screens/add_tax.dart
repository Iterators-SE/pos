import 'package:flutter/material.dart';

class AddTaxScreen extends StatefulWidget {
  @override
  _AddTaxScreenState createState() => _AddTaxScreenState();
}

class _AddTaxScreenState extends State<AddTaxScreen>{
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Add Tax')      
    ),
    body: Center(
      child: Container(
      margin: EdgeInsets.all(20.0),
      width: 400 ,
      height: 250,
        child: Column(
        children: <Widget>[
          Text("Name",
            style: TextStyle(fontSize: 25)
          ),
          TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )), 
            ),
            SizedBox(
              height: 25.0,
            ),
            Text("Percent",
              style: TextStyle(fontSize: 25)
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Percentage',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
            )),
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 150.0,
            child: ElevatedButton( 
              child: Text(
                'Save',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {}
            ))
        ]
      )
      )
    ));
}}
