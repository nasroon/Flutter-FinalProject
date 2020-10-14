import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AddScreenClass extends StatefulWidget {
  @override
  _AddScreenClassState createState() => _AddScreenClassState();
}

class _AddScreenClassState extends State<AddScreenClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD Class"),
      ),
      body: new Container(
          padding: new EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: new SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool pressed = true;
  final _formKey = GlobalKey<FormState>();
  final values = List.filled(7, false);
  String _course = '';
  String _room = '';
  String _maritalStatus = 'each';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: new ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();
    formWidget.add(new SizedBox(
      height: 20,
    ));
    formWidget.add(new Row(children: <Widget>[
      Text(
        "Course : ",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width / 2,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter Course Name',
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              _course = value;
            });
          },
        ),
      )
    ]));

    formWidget.add(new SizedBox(
      height: 10,
    ));

    formWidget.add(new Row(children: <Widget>[
      Text(
        "Room : ",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width / 2,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter Room Name',
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              _room = value;
            });
          },
        ),
      )
    ]));

    formWidget.add(new Text(
      "Day",
      style: TextStyle(
        fontSize: 30,
      ),
    ));

    formWidget.add(new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'The days that are currently selected are: ${valuesToEnglishDays(values, true)}.',
          style: pressed
              ? TextStyle(color: Colors.black)
              : TextStyle(color: Colors.red),
        ),
        WeekdaySelector(
          selectedFillColor: Colors.indigo,
          onChanged: (v) {
            setState(() {
              values[v % 7] = !values[v % 7];
            });
          },
          values: values,
        ),
      ],
    ));

    formWidget.add(new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 3,
              child: BasicTimeField1()),
          Text(
            "To",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 3,
              child: BasicTimeField2())
        ]));

    bool checking() {
      if (valuesToEnglishDays(values, true) == '-') {
        setState(() {
          pressed = false;
        });
        return false;
      }
       else {
        setState(() {
          pressed = true;
        });
      }
      return true;
    }

    void onPressedSubmit() {
      if (_formKey.currentState.validate() && checking()) {
        _formKey.currentState.save();
        print("Course " + _course);
        print("Room " + _room);
        print("Day " + valuesToEnglishDays(values, true));
        print(pickTime(times1));
        print(pickTime(times2));
        //print(pickTime(times1.toString()));

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Form Submitted')));
      }
    }

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('Add'),
        onPressed: onPressedSubmit));

    return formWidget;
  }
}


String pickTime(String time) {
  var arr = time.split('(');
  var fin = arr[1].split(')');
  return fin[0];
}


String intDayToEnglish(int day) {
  if (day % 7 == DateTime.monday % 7) return 'Monday';
  if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
  if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
  if (day % 7 == DateTime.thursday % 7) return 'Thursday';
  if (day % 7 == DateTime.friday % 7) return 'Friday';
  if (day % 7 == DateTime.saturday % 7) return 'Saturday';
  if (day % 7 == DateTime.sunday % 7) return 'Sunday';
  throw '🐞 This should never have happened: $day';
}

String valuesToEnglishDays(List<bool> values, bool searchedValue) {
  final days = <String>[];
  for (int i = 0; i < values.length; i++) {
    final v = values[i];
    if (v == searchedValue) days.add(intDayToEnglish(i));
  }
  if (days.isEmpty) return '-';
  return days.join(', ');
}

String times1;
String times2;

class BasicTimeField1 extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: "Enter Time",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          times1 = time.toString();
          return DateTimeField.convert(time);
        },
        validator: (date) => date == null ? 'Invalid date' : null,
      ),
    ]);
  }
}

class BasicTimeField2 extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: "Enter Time",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          times2 = time.toString();
          return DateTimeField.convert(time);
        },
        validator: (date) => date == null ? 'Invalid date' : null,
      ),
    ]);
  }
}
