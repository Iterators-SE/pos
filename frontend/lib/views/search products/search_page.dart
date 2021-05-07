import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = coffeeData;
    List<Widget> listItems = responseList.map((post) {
        return Card(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Container(
            height: 126,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey[500], blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      Text(
                        post["name"],
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\Stocks left: ${post["stocks"]}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        post["description"],
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 50.0,
                        height: 20.0, 
                        child: TextButton(  
                        child: Text(
                          'edit', 
                          style: TextStyle(fontSize: 12.0),
                        ),  
                        onPressed: () {},  
                        ),  
                      )

                    ],
                  ),
                  
                ],
              ),
            ),
          ),

      );
    }).toList();

    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon (
          Icons.arrow_back_ios_sharp,
          color: Colors.black,
          size: 30.0,
        ),     
      ),    
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(35.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
              'Search',
                style: TextStyle(
                color: Colors.black,
                fontSize: 48.0,
                ),
              ),
              SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'search products ...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder( 
                      borderRadius: BorderRadius.circular(25),              
                    ),
                    ),
                  ),               
              Expanded(
                child: ListView.builder(
                    controller: controller,
                    itemCount: itemsData.length,
                    itemBuilder: (context, index) {
                      
                      var scale = 1.0;
                      if (topContainer > 0.5) {
                        scale = index + 0.5 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                      return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform: Matrix4.identity()..scale(scale, scale),
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          )
                        );

                        
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
