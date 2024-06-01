import 'package:beautfy_center/model/user/get_all_employees_response.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';

class AdminEmployeeCubit extends Cubit<AdminEmployeeState> {
  IUserService service;
  GetAllEmployesResponse? data;
  bool isLoading = false;
  AdminEmployeeCubit({required this.service}) : super(AdminEmployeeInitial()){
    getAllEmployee();
  }

  getAllEmployee() async {
    changeLoading();
    data = await service.GetAllEmployes();
    changeLoading();
  }

  changeLoading() {
    isLoading = !isLoading;
    emit(AdminEmployeeLoading());
  }
    delete(int? id) async {
  
    await service.Delete(id);
    
    getAllEmployee();
  }
}

class AdminEmployeeState {}

class AdminEmployeeInitial extends AdminEmployeeState {}

class AdminEmployeeLoading extends AdminEmployeeState {}
