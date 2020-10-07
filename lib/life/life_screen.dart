import 'package:flutter/material.dart';
import 'package:lifestudy/life/add-edit_screen_life.dart';

class LifeScreen extends StatefulWidget {
  @override
  _LifeScreenState createState() => _LifeScreenState();
}

class _LifeScreenState extends State<LifeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(
          "Life +",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
        context, MaterialPageRoute(builder: (context) => AddScreenLife("Add Life+")));
  }
}
