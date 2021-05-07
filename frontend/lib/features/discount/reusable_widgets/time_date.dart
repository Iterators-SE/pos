import 'package:flutter/material.dart';
import 'time_date_container.dart';

class TimeAndDate extends StatefulWidget {
  @override
  _TimeAndDateState createState() => _TimeAndDateState();
}

class _TimeAndDateState extends State<TimeAndDate> {
  DateTime dateFrom;
  TimeOfDay timeFrom;
  DateTime dateUntil;
  TimeOfDay timeUntil;

  String getDateFrom() {
    if (dateFrom == null) {
      return "Select date";
    } else {
      return '${dateFrom.month}/${dateFrom.day}/${dateFrom.year}';
    }
  }

  String getDateUntil() {
    if (dateUntil == null) {
      return "Select date";
    } else {
      return '${dateUntil.month}/${dateUntil.day}/${dateUntil.year}';
    }
  }

  String getTimeFrom() {
    if (timeFrom == null) {
      return "Select time";
    } else {
      final hour = timeFrom.hour.toString().padLeft(2, '0');
      final minutes = timeFrom.minute.toString().padLeft(2, '0');
      return '$hour:$minutes';
    }
  }

  String getTimeUntil() {
    if (timeUntil == null) {
      return "Select time";
    } else {
      final hour = timeUntil.hour.toString().padLeft(2, '0');
      final minutes = timeUntil.minute.toString().padLeft(2, '0');
      return '$hour:$minutes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text("From:", style: TextStyle(fontSize: 17),),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: pickdate,
                    child: timeAndDateContainer(getDateFrom()) 
                    ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: pickTime,
                    child: timeAndDateContainer(getTimeFrom())
                    )
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Until:", style: TextStyle(fontSize: 17),),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: pickdate2,
                    child: timeAndDateContainer(getDateUntil()) 
                    ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: pickTime2,
                    child: timeAndDateContainer(getTimeUntil())
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future pickdate() async {
    final initialDate = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: dateFrom ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        dateFrom = date;
      });
    }
  }

  Future pickdate2() async {
    final initialDate = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: dateUntil ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        dateUntil = date;
      });
    }
  }

   Future pickTime() async {
    final initialTime = TimeOfDay(hour: 12, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: timeFrom ?? initialTime);

    if (newTime != null) {
      setState(() {
        timeFrom = newTime;
      });
    }
  }

  Future pickTime2() async {
    final initialTime = TimeOfDay(hour: 12, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: timeUntil ?? initialTime);

    if (newTime != null) {
      setState(() {
        timeUntil = newTime;
      });
    }
  }
}
