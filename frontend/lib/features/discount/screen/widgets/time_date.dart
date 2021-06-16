import 'package:flutter/material.dart';
import 'time_date_container.dart';

class TimeAndDate extends StatefulWidget {
  final Function setStartTime;
  final Function setEndTime;
  final Function setStartDate;
  final Function setEndDate;

  TimeAndDate({
    Key key,
    this.setEndDate,
    this.setStartDate,
    this.setStartTime,
    this.setEndTime,
  }) : super(key: key);

  @override
  _TimeAndDateState createState() => _TimeAndDateState();
}

class _TimeAndDateState extends State<TimeAndDate> {
  DateTime dateFrom;
  TimeOfDay timeFrom;
  DateTime dateUntil;
  TimeOfDay timeUntil;

  String getDate(DateTime date) {
    return date == null
        ? "Select date"
        : '${dateUntil.month}/${dateUntil.day}/${dateUntil.year}';
  }

  String getTime(TimeOfDay time) {
    if (time == null) {
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
            child: Text(
              "From:",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: pickStartDate,
                    child: timeAndDateContainer(getDate(dateFrom)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: pickStartTime,
                    child: timeAndDateContainer(getTime(timeFrom)),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Until:",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: pickEndDate,
                    child: timeAndDateContainer(getDate(dateUntil)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: pickEndTime,
                    child: timeAndDateContainer(getTime(timeUntil)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future pickStartDate() async {
    final initialDate = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: dateFrom ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        dateFrom = date;
        widget.setStartDate(dateFrom);
      });
    }
  }

  Future pickEndDate() async {
    final initialDate = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: dateUntil ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        dateUntil = date;
        widget.setEndDate(dateUntil);
      });
    }
  }

  Future pickStartTime() async {
    final initialTime = TimeOfDay(hour: 12, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: timeFrom ?? initialTime);

    if (newTime != null) {
      setState(() {
        timeFrom = newTime;
        widget.setStartTime(timeFrom);
      });
    }
  }

  Future pickEndTime() async {
    final initialTime = TimeOfDay(hour: 12, minute: 0);
    final newTime = await showTimePicker(
        context: context, initialTime: timeUntil ?? initialTime);

    if (newTime != null) {
      setState(() {
        timeUntil = newTime;
        widget.setEndTime(timeUntil);
      });
    }
  }
}
