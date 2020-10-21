import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestudy/Bloc/add_cubit.dart';
import 'package:lifestudy/study/add-edit_screen_class.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:lifestudy/study/slide_background.dart';
import 'data_class.dart';

List<DataClass> list = [
  DataClass("JJ", "x"),
  DataClass("Poon", "y"),
  DataClass("Geng", "z"),
  DataClass("John", "z")
];

final options = LiveOptions(
  delay: Duration(seconds: 1),
  showItemInterval: Duration(milliseconds: 100),
  showItemDuration: Duration(milliseconds: 100),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);

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
      body: LiveList.options(
        options: options,
        itemBuilder: buildAnimatedItem,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
      ),
      // Column(
      //   children: [
      //     BlocBuilder<AddCubit, List>(builder: (context, state) {
      //       return Text('$state',
      //           style: TextStyle(
      //             fontSize: 20,
      //           ));
      //     })
      //   ],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //context.bloc<AddCubit>().addData('xxxxxxxxxxxx');
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

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: buildRow(context, index),
        ),
      );
Widget buildRow(BuildContext context, int i) {
    DataClass item = list[i];
    return Dismissible(
      key: Key(item.name),
      background: slideLeftBackground(),
      secondaryBackground: slideRightBackground(),
      child: makeCard(i),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                      "Are you sure you want to delete ${list[i].name}?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        setState(() {
                          list.removeAt(i);
                          //idUpdate();
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return res;
        } else {
          //_awaitReturnValueFromEditScreen2(context, i);
        }
      },
    );
  }

Widget makeCard(int i) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: buildList(i),
      ),
    );
  }

  Widget buildList(int i) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white))),
          child: Text(
            "${i + 1} ",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          "${list[i].name}",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        //subtitle: Text(" ", style: TextStyle(color: Colors.white)),
        trailing: Container(
          child: Text(
            "${list[i].sur}",
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: () => {
          //_awaitReturnValueFromShowScreen(context, i)
          });
  }
}

