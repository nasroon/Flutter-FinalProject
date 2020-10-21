import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestudy/study/add-edit_screen_study.dart';

import '../Bloc/add_cubit.dart';

class StudyScreen extends StatefulWidget {
  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          "Study",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),

      // body: Column(
      //   children: [
      //     BlocBuilder<AddCubit, List>(builder: (context, state) {
      //       return new Column(
      //           children:
      //               state.map((item) => new Text(item.lastName)).toList());
      //     })
      //   ],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   context
          //       .bloc<AddCubit>()
          //       .addData(DataStudy('xxxx', 'yyyyyyy', 'zzzz'));
          // });
          _awaitAdd();
        },
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
        context, MaterialPageRoute(builder: (context) => AddScreenStudy()));
  }
}
