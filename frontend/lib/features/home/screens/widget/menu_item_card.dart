import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/themes/config.dart';
import '../../models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final String imagePath;
  final MenuItem element;

  const MenuItemCard(
      {Key key, @required this.element, @required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = AssetImage(imagePath);
    return InkWell(
      onTap: element.onTap,
      child: Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: xposGreen[600],
        gradient: LinearGradient(
          colors: [xposGreen[600], xposGreen[300]],
          stops: [0.0, 0.5]
        ),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: image,
          scale: 2.0,
          alignment: Alignment.centerLeft
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            offset: Offset(4.0, 4.0),
            blurRadius: 5.0,
            spreadRadius: 1.50
          )
        ]
      ),
      child: Container(
        margin: EdgeInsets.only(left: 130),
        child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            element.option,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Montserrat Bold",
              fontSize: 23,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
      ),
    ),
    );
  }

//   Widget buildImage() {
//     final image = AssetImage(imagePath);

//     return Material(
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//       color: xposGreen[400],
//       child: ClipOval(
//         child: Ink.image(
//           image: image,
//           fit: BoxFit.fitHeight,
//           width: 150,
//           height: double.maxFinite,
//         ),
//       ),
//     );
//   }
 }

// InkWell(
//         onTap: element.onTap,
//         child: Container(
//           height: 100,
//           decoration: BoxDecoration(
//             //image: ,
//              color: xposGreen[400],
//               //border: Border.all(color: xposGreen),
//               borderRadius: BorderRadius.circular(30),
//               // gradient: LinearGradient(
//               //   colors: [Colors.blueGrey[50], xposGreen[50]],
//               //   begin: Alignment.topCenter,
//               //   end: Alignment.bottomCenter,
//               // )
//               // color: Colors.blueGrey[colorCodes.asMap()]
//               ),
//           child: Center(
//             child: Text(
//               element.option,
//               style: TextStyle(

//               )
//               )
//           ),
//         ),
//       )