import 'package:flutter/material.dart';
import 'package:frontend/features/discount/reusable_widgets/duration_container.dart';

Widget duration() {
  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Date:",
            style: TextStyle(fontSize: 17),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: <Widget>[
              Expanded(flex: 2, child: durationContainer("Feb 1")),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(" to "),
                  )),
              Expanded(
                flex: 2,
                child: durationContainer("Feb 19"),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Time:",
            style: TextStyle(fontSize: 17),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: <Widget>[
              Expanded(flex: 2, child: durationContainer("9:00 am")),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(" to "),
                  )),
              Expanded(
                flex: 2,
                child: durationContainer("5:00 pm"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
