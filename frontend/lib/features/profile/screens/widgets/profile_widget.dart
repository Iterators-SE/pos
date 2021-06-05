//import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/config.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    key,
    @required this.imagePath,
    @required this.onClicked,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = xposGreen;
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(bottom: 0, right: 4, child: buildEditIcon(color))
      ]),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
        child: Material(
      child: Ink.image(
        image: image,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
        child: InkWell(onTap: onClicked),
      ),
    ));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: InkWell(
            onTap: onClicked,
            child: Icon(
              isEdit ? Icons.add_a_photo : Icons.edit,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget buildCircle({Color color, double all, Widget child}) => ClipOval(
        child: Container(
          child: child,
          color: color,
          padding: EdgeInsets.all(all),
        ),
      );
}
