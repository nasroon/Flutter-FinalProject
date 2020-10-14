import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
  List<bool> day = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> Nameday = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
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
              cleardata(value.toString());
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
              cleardata(value.toString());
              _maritalStatus = value;
            });
          },
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            checkbox("Mon", day[0]),
            checkbox("Tu", day[1]),
            checkbox("Wed", day[2]),
            checkbox("Thur", day[3]),
            checkbox("Fri", day[4]),
            checkbox("Sat", day[5]),
            checkbox("Sun", day[6]),
          ],
        ))
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

    void onPressedSubmit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        print("Name " + _name);
        print("Day " + _day);
        print("Repeated " + _maritalStatus);
        print(times.toString());
        for (int i = 0; i < day.length; i++)
          if (day[i]) {
            print(Nameday[i]);
          }

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
        for (int i = 0; i < day.length; i++) day[i] = false;
      });
    } else
      setState(() {
        nameHolder.clear();
      });
  }

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            setState(() {
              switch (title) {
                case "Mon":
                  day[0] = value;
                  break;
                case "Tu":
                  day[1] = value;
                  break;
                case "Wed":
                  day[2] = value;
                  break;
                case "Thur":
                  day[3] = value;
                  break;
                case "Fri":
                  day[4] = value;
                  break;
                case "Sat":
                  day[5] = value;
                  break;
                case "Sun":
                  day[6] = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }
}

String times;

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: "Enter Event name",
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
