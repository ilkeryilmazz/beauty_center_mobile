import 'package:beautfy_center/model/user/get_all_employees_response.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';

class CustomerEmployeesCubit extends Cubit<CustomerEmployeesState> {
  GetAllEmployesResponse? data;
  IUserService service;
  bool isLoading = false;
  CustomerEmployeesCubit({required this.service})
      : super(CustomerEmployeesInitial()) {
    getAll();
  }

  getAll() async {
    _changeLoading();
    data = await service.GetAllEmployes();
    _changeLoading();
  }
  _changeLoading(){
    isLoading = !isLoading;
    emit(CustomerEmployeesLoading());
  }

}

class CustomerEmployeesInitial extends CustomerEmployeesState {}

class CustomerEmployeesLoading extends CustomerEmployeesState {}

class CustomerEmployeesState {}
