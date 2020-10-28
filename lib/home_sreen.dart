import 'package:flutter/material.dart';
import 'package:lifestudy/config/routes.dart';
import 'package:lifestudy/life/life_screen.dart';
import 'package:lifestudy/study/mediator%20.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/add_cubit.dart';

bool firtTime = true;
TextEditingController username = TextEditingController();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        body: firtTime ? yes() : no());
  }

  Widget no() {
    return Column(children: <Widget>[
      Expanded(child: lifeplus()),
      Expanded(child: studyplus())
    ]);
  }

  Widget yes() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Hi !",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
                hintText: "Enter your name",
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 3.0),
            ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width: 3.0),
                ),
                //labelText: 'Enter  Name',
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            onPressed: () => {
              context
                  .bloc<AddLifeCubit>()
                  .addFullName(username.text.toString()),
              print(username.text.toString()),
              firtTime = false,
              Navigator.of(context)
                  .pushNamed(AppRoutes.home, arguments: HomeScreen()),
            },
            color: Colors.amber[400],
            child: Text(
              'Enter',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
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
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LifeScreen()));
  }

  void _awaitClasScreen() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MediatorScreen()));
  }
}
