import 'package:flutter/material.dart';

class ReceiptScreen extends StatefulWidget {
  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen>  {

  Widget _personnel() {
    return Container(
      width: 350,
      height: 50,
      child: TextFormField(
      decoration: InputDecoration(
          labelText: 'Personnel',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      maxLength: 15,
    )
    );
  }

  Widget _date() {
    return Container(
      width: 350,
      height: 50,
      child: TextFormField(
      decoration: InputDecoration(
          labelText: 'Date',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      maxLength: 15,
    )
    );
  }

  Widget _orderDetails(){
    return Container(  
      margin: EdgeInsets.all(30), 
      child: Table(  
      defaultColumnWidth: 
        FlexColumnWidth(500.0), 
      children: [ 
        TableRow( children: [  
          Column(children:[
            Text('Product', 
            style: TextStyle(fontSize: 17.0),
          )]),  
          Column(children:[
            Text('Quantity', 
            style: TextStyle(fontSize: 17.0))]),  
          Column(children:[
            Text('Price', 
            style: TextStyle(fontSize: 17.0))]),  
          Column(children:[
            Text('Total', 
            style: TextStyle(fontSize: 17.0))]),  
        ]),  
        TableRow( children: [  
          Column(children:[Text('Cake')]),  
          Column(children:[Text('2')]),  
          Column(children:[Text('100')]), 
          Column(children:[Text('90')])  
        ]),  
        TableRow( children: [  
          Column(children:[Text('Coffee')]),  
          Column(children:[Text('1')]),  
          Column(children:[Text('150')]), 
          Column(children:[Text('150')])  
        ]),  
      ],  
      )
    );  
  }

  Widget _addedDetails() {
    return Container(  
      margin: EdgeInsets.all(30), 
      child: Table(  
      defaultColumnWidth: 
        FlexColumnWidth(500.0), 
      children: [ 
        TableRow( children: [  
          Column(children:[Text('Price')]),  
          Column(children:[Text('')]), 
          Column(children:[Text('')]), 
          Column(children:[Text('240')]),  
        ]),  
        TableRow( children: [  
          Column(children:[Text('VAT')]),  
          Column(children:[Text('')]), 
          Column(children:[Text('')]),
          Column(children:[Text('28.80')]),           
        ]),
        TableRow( children: [  
          Column(children:[Text('Discount')]), 
          Column(children:[Text('')]), 
          Column(children:[Text('')]), 
          Column(children:[Text('36.00')]),           
        ]),   
        TableRow( children: [  
          Column(children:[
            Text('Total',
            style: TextStyle(
              fontSize: 17.0),
          )]),    
          Column(children:[Text('')]), 
          Column(children:[Text('')]),
          Column(children:[
            Text('232.80',
            style: TextStyle(
              fontSize: 17.0),
          )]),            
        ]),   
      ]
      ),         
    );        
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Process Orders")),
      body: Column(
        children: <Widget>[ 
        SizedBox(height: 15),
        Text(
          'Order No. 46',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        SizedBox(height: 15),
        _personnel(),
        SizedBox(height: 15),
        _date(),
        _orderDetails(),           
        _addedDetails(),
        Text(
          'This serves as an OFFICIAL RECEIPT',
        ),
        SizedBox(height: 40),
        ElevatedButton(
          child: Text(
            'Print',
            style: TextStyle(),
          ),
          onPressed: () {} 
        )
      ]
      )   
    );
}
}