import 'package:flutter/material.dart';
import 'package:lifestudy/life/life_screen.dart';
import 'package:lifestudy/study/mediator%20.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: Column(children: <Widget>[
          Expanded(child: lifeplus()),
          Expanded(child: studyplus())
        ]));
  }

  Widget lifeplus() {
    return InkWell(
        onTap: () => {_awaitLifeScreen()},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Center(
              child: Text('Life+',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ));
  }

  Widget studyplus() {
    return InkWell(
        onTap: () => {_awaitClasScreen()},
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                child: Text(
                  'Study+',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Segoe',
                  ),
                ),
              ),
            )));
  }

  void _awaitLifeScreen() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LifeScreen()));
  }

  void _awaitClasScreen() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MediatorScreen()));
  }
}
