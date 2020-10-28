import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:lifestudy/Bloc/add_cubit.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

List documents = [];

class _AddScreenLifeState extends State<AddScreenLife> {
  final databaseReference = Firestore.instance;
  void initState() {
    super.initState();
    documents.clear();
    setState(() {
      databaseReference
          .collection("life")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => documents.add(f.data));
      });
    });
  }

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
  final values = List.filled(7, false);
  final _formKey = GlobalKey<FormState>();
  final nameHolder = TextEditingController();
  String _name = '';
  int _day = 0;
  String _maritalStatus = 'each';

  final databaseReference = Firestore.instance;

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
              //cleardata('each');
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
                  _day = int.parse(value);
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
      ],
    ));
    formWidget.add(new SizedBox(
      height: 20,
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

    void rec(BuildContext context) async {
      await databaseReference
          .collection("life")
          .document((documents.length + 1).toString()) ////////////////////////
          .setData({
        'Name': _name,
        'Repeated': _maritalStatus,
        'Every': _day,
        'Time': pickTime(times)
      });
      //context.bloc<AddLifeCubit>().inc();
    }

    void onPressedSubmit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        print("Name " + _name);
        print("Every " + _day.toString());
        print(pickTime(times));

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Form Submitted')));

        rec(context);
        documents.clear();
        Navigator.of(context).pop();
      }
    }

    formWidget.add(new Text(
      documents.length.toString(),
      style: TextStyle(color: Colors.white),
    )); /////////////////////////////

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
