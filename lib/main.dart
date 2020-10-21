import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifestudy/Bloc/add_cubit.dart';
import 'package:lifestudy/Bloc/add_observer.dart';
import 'package:lifestudy/config/routes.dart';
import 'package:bloc/bloc.dart';
import 'home_sreen.dart';

void main() {
  Bloc.observer = AddObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "navigator",
        theme: new ThemeData(
            primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Segoe'),
        routes: {
          AppRoutes.home: (context) => HomeScreen(),
        },
      ),
    );
  }
}
