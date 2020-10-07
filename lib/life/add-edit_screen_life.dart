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
  final _formKey = GlobalKey<FormState>();

  String _name = '';
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
        "Event : ",
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
              _maritalStatus = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('specific day'),
          value: 'specific',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value;
            });
          },
        ),
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

String times;

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
          times = time.toString();
          return DateTimeField.convert(time);
        },
        validator: (date) => date == null ? 'Invalid date' : null,
      ),
    ]);
  }
}
