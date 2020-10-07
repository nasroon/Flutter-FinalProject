import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

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
  final _formKey = GlobalKey<FormState>();

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
          decoration: InputDecoration(labelText: 'Enter Event Name'),
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
          decoration: InputDecoration(labelText: 'Enter Event Name'),
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

    formWidget.add(new Row(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width / 3,
          child: BasicTimeField()),
      Text(
        "To",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Container(
          width: MediaQuery.of(context).size.width / 3, child: BasicTimeField())
    ]));

    void onPressedSubmit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        print("Course " + _course);
        print("Room " + _room);
        print("Repeated " + _maritalStatus);
        print(times.toString());
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

List <String>times =[];

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          if(times == null)
            times.add(time.toString());
          else
            times.add(time.toString());
          return DateTimeField.convert(time);
        },
        validator: (date) => date == null ? 'Invalid date' : null,
      ),
    ]);
  }
}
