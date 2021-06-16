import 'package:flutter/material.dart';
import 'duration_container.dart';

Widget duration({
  String startDate,
  String endDate,
  String startTime,
  String endTime,
}) {
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
              Expanded(flex: 2, child: durationContainer(startDate)),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(" to "),
                  )),
              Expanded(
                flex: 2,
                child: durationContainer(endDate),
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
              Expanded(flex: 2, child: durationContainer(startTime)),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(" to "),
                  )),
              Expanded(
                flex: 2,
                child: durationContainer(endTime),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
