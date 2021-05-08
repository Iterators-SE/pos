import 'package:flutter/material.dart';
 
class searchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
        appBar: AppBar(
        title: Text('Flutter Apply Search on ListView')
          ),
        body: Center(
          child: ListSearch()
          )
        )
      );
  }
}
 
class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}
 
class ListSearchState extends State<ListSearch> {
 
  TextEditingController _textController = TextEditingController();
 
  static List<String> mainDataList = [
   "Coffee",
   "Cake",
   "Shake",
   "Cupcake",
   "Tea",
  ];
 
  // Copy Main List into New List.
  List<String> newDataList = List.from(mainDataList);
 
  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search Here...',
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newDataList.map((data) {
                return ListTile(
                  title: Text(data),
                  onTap: ()=> print(data),);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}