import 'package:flutter/material.dart';
import 'receipt.dart';

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen>  {

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
            Container(  
              margin: EdgeInsets.all(30),  
              child: Table(  
                defaultColumnWidth: 
                  FlexColumnWidth(200.0),                         
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
              ),  
            ),
            _addedDetails(),
            ElevatedButton(
              child: Text(
                'Checkout',
                style: TextStyle(),
              ),
              onPressed: () => 
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReceiptScreen()),
            ))
          ])  
      
        
    );

    
  }
}