import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestudy/Bloc/add_cubit.dart';
import 'package:lifestudy/study/add-edit_screen_study.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudyScreen extends StatefulWidget {
  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final databaseReference = Firestore.instance;
  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('study').orderBy('Time').getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Study",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            BlocBuilder<AddLifeCubit, String>(
              builder: (context, state) {
                return Text('$state');
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getPost(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child:
                    Text("Loading....", style: TextStyle(color: Colors.white)),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            title: Text(
                              snapshot.data[index].data["Course"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(snapshot.data[index].data["Time"],
                                style: TextStyle(color: Colors.white)),
                            trailing: Container(
                              child: Text(
                                snapshot.data[index].data["MileStone"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onTap: () {alert(snapshot.data[index].documentID);}),
                      ),
                    );
                  });
            }
          }),
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
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddScreenStudy()));
    setState(() {});
  }

  void deleteData(String index) {
    try {
      databaseReference.collection('study').document(index).delete();
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  void alert(String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Are you sure you want to delete"),
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
                    deleteData(id);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
