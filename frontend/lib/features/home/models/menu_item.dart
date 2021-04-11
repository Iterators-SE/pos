import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MenuItem {
  final String option;
  final String url;
  final Function onTap;

  const MenuItem({
    Key key,
    @required this.option,
    @required this.url,
    this.onTap,
  });
}
