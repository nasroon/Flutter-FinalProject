import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:weekday_selector/weekday_selector.dart';
// class LifeParameter{
//   final String title;
//   LifeParameter(this.title);
// }

class AddScreenLife extends StatefulWidget {
  final String title;
  AddScreenLife(this.title, {Key key}) : super(key: key);
  @override
  _AddScreenLifeState createState() => _AddScreenLifeState();
}

class _AddScreenLifeState extends State<AddScreenLife> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
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
  final values = List.filled(7, false);
  final _formKey = GlobalKey<FormState>();
  final nameHolder = TextEditingController();
  String _name = '';
  String _day = '';
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
        "Event : ",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width / 2,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "Enter Event name",
            fillColor: Colors.white,
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
              _name = value;
            });
          },
        ),
      )
    ]));

    formWidget.add(new Text(
      "Repeated :",
      style: TextStyle(
        fontSize: 30,
      ),
    ));

    formWidget.add(new Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('each'),
          value: 'each',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              cleardata('each');
              _maritalStatus = value;
            });
          },
        ),
        Row(children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: TextFormField(
              controller: nameHolder,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
              validator: (value) {
                if (value.isEmpty && _maritalStatus == 'each') {
                  return 'Please enter a Day';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _day = value;
                });
              },
            ),
          ),
          Text(
            " Day",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ]),
        RadioListTile<String>(
          title: const Text('specific day'),
          value: 'specific',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              cleardata('specific');
              _maritalStatus = value;
            });
          },
        ),
        Column(
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
        )
      ],
    ));

    formWidget.add(new Row(children: <Widget>[
      Text(
        "Time : ",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Container(
          width: MediaQuery.of(context).size.width / 2, child: BasicTimeField())
    ]));

    bool checking() {
      if (_maritalStatus == 'each')
        return true;
      else if (_maritalStatus == 'specific') {
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
    }

    void onPressedSubmit() {
      if (_formKey.currentState.validate() && checking()) {
        _formKey.currentState.save();
        print("Name " + _name);
        print("Repeated " + _maritalStatus);
        print("Every " + _day);
        print(valuesToEnglishDays(values, true));
        print(pickTime(times));

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

  void cleardata(String value) {
    if (value == 'each') {
      setState(() {
        for (int i = 0; i < values.length; i++) values[i] = false;
        //values[v % 7] = !values[v % 7];
      });
    } else
      setState(() {
        nameHolder.clear();
      });
  }
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
    // Use v == true, as the value could be null, as well (disabled days).
    if (v == searchedValue) days.add(intDayToEnglish(i));
  }
  if (days.isEmpty) return '-';
  return days.join(', ');
}

String pickTime(String time) {
  var arr = time.split('(');
  var fin = arr[1].split(')');
  return fin[0];
}

String times;

class BasicTimeField extends StatelessWidget {
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
          times = time.toString();
          return DateTimeField.convert(time);
        },
        validator: (date) => date == null ? 'Invalid date' : null,
      ),
    ]);
  }
}
