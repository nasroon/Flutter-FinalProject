import 'package:bloc/bloc.dart';


class AddCubit extends Cubit<List>{
  AddCubit() : super(List());
  void increment(data) => state.add(data);


}