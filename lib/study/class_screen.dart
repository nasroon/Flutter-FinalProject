import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestudy/Bloc/add_cubit.dart';
import 'package:lifestudy/study/add-edit_screen_class.dart';

class ClassScreen extends StatefulWidget {
  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          "Class",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<AddCubit, List>(builder: (context, state) {
            return Text('$state',
                style: TextStyle(
                  fontSize: 20,
                ));
          })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            context.bloc<AddCubit>().increment('xxxxxxxxxxxx');
          });
        },//////////////////////////////
        //{_awaitAdd();},
        child: Icon(
          Icons.add,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _awaitAdd() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddScreenClass()));
  }
}
