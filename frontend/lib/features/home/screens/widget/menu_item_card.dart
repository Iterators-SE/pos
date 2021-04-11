import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
        height: 180,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.brown[400]),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(element.url),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            element.option,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Montserrat Bold",
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
