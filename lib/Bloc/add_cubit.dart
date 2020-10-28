import 'package:bloc/bloc.dart';


class AddLifeCubit extends Cubit<String>{
  AddLifeCubit() : super('');
  void addFullName(String fullName) => emit(state + fullName);
  // void inc() => emit(state +1);
  // void dec() => emit(state -1);
}
