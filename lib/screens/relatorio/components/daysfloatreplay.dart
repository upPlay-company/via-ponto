import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class DaysFloatReplay extends StatefulWidget {
  @override
  _DaysFloatReplayState createState() => _DaysFloatReplayState();
}

class _DaysFloatReplayState extends State<DaysFloatReplay> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.blueGrey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: DatePicker(
                  DateTime.now(),
                  width: 80,
                  height: 100,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  inactiveDates: [
                    DateTime.now().add(Duration(days: 3)),
                    DateTime.now().add(Duration(days: 4)),
                    DateTime.now().add(Duration(days: 7))
                  ],
                  onDateChange: (date) {
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
