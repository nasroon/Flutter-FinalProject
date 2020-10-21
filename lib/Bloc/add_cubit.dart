import 'package:bloc/bloc.dart';


class AddCubit extends Cubit<List<DataStudy>>{
  AddCubit() : super([]);
  void addData(data) => {state.add(data)};
}

class DataStudy {
  String eventName;
  String mileStone;
  String description;
  String deadlineDate;

  DataStudy(this.eventName, this.mileStone, this.description,this.deadlineDate);
}