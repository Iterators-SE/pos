import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/themes/config.dart';
import '../../models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem element;

  const MenuItemCard({Key key, @required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: element.onTap,
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(color: xposGreen),
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blueGrey[50], xposGreen[50]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            // color: Colors.blueGrey[colorCodes.asMap()]
            ),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage(element.url),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  element.option,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Montserrat Bold",
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
