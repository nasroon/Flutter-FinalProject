import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Bloc/add_cubit.dart';

class AddScreenStudy extends StatefulWidget {
  @override
  _AddScreenStudyState createState() => _AddScreenStudyState();
}

List documents = [];

class _AddScreenStudyState extends State<AddScreenStudy> {

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
    return Scaffold(
      appBar: AppBar(title: Text("ADD Study")),
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
  String _stone = '';
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
            labelText: 'Enter Study Name',
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
    formWidget.add(new SizedBox(
      height: 20,
    ));
    formWidget.add(new Row(children: <Widget>[
      Text(
        "Milestone : ",
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width / 2,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter MileStone',
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
              _stone = value;
            });
          },
        ),
      )
    ]));

    formWidget.add(new Text(
      "Description",
      style: TextStyle(
        fontSize: 30,
      ),
    ));

    formWidget.add(new TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 5,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    ));

    formWidget.add(new Text(
      "Deadline",
      style: TextStyle(
        fontSize: 30,
      ),
    ));

    formWidget.add(new Row(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width / 2,
          child: BasicDateTimeField()),
    ]));


    void rec(BuildContext context) async {
      await databaseReference
          .collection("study")
          .document((documents.length + 1).toString())
          .setData({
        'Course': _name,
        'MileStone': _stone,
        'Repeated': _maritalStatus,
        'Time': times.toString().split('.')[0],
      });
      //context.bloc<AddLifeCubit>().inc();
    }

    void onPressedSubmit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        print("Course " + _name);
        print("Room " + _stone);
        print("Repeated " + _maritalStatus);
        print(times.toString().split('.')[0]);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Form Submitted')));
        rec(context);
        documents.clear();
        Navigator.of(context).pop();
      }
    }

    formWidget.add(
        new Text(documents.length.toString(),style: TextStyle(color: Colors.white),));

    formWidget.add(new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: new Text('Add'),
        onPressed: onPressedSubmit));

    return formWidget;
  }
}

String times;

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
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
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            times = DateTimeField.combine(date, time).toString();
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        validator: (date) => date == null ? 'Invalid date' : null,
      ),
    ]);
  }
}
