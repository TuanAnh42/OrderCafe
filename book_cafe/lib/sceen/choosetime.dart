import 'package:flutter/material.dart';

class MyChooseTime extends StatefulWidget {
  @override
  _MyChooseTimeState createState() => _MyChooseTimeState();
  TimeOfDay getStartTime() {
    return _MyChooseTimeState.startTime;
  }

  TimeOfDay getEndTime() {
    return _MyChooseTimeState.endTime;
  }
}

class _MyChooseTimeState extends State<MyChooseTime> {
  static TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  static TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);
  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Bắt đầu: ",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () => selectStartTime(context),
              child: Text("${startTime.format(context)} "),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              "Kết thúc: ",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () => selectEndTime(context),
              child: Text(" ${endTime.format(context)}"),
            ),
          ],
        ),
      ]),
    );
  }
}
