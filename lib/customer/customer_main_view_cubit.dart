import 'package:beautfy_center/model/service/service_model.dart';
import 'package:beautfy_center/model/user/employee_with_serviceid_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:beautfy_center/services/IServiceService.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CustomerMainViewCubit extends Cubit<CustomerMainViewState> {
  bool isLoading = false;
  IServiceService service;
  ServiceModel? data;
  IUserService userService;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String? selectedEmployee;
  EmployeeWithServiceIdResponse? users;

  List<DropdownMenuItem<String>>? dropdownItems = [
    DropdownMenuItem(child: Text("Lütfen bir çalışan seçin"))
  ];
  CustomerMainViewCubit({required this.userService, required this.service})
      : super(CustomerMainViewInitial()) {
    getAllServices();
  }


  _changeLoading() {
    isLoading = !isLoading;
    emit(CustomerMainViewLoadingState());
  }

  setItems() {
    dropdownItems = List.generate(
        users!.data!.length,
        (index) => DropdownMenuItem(
            value: users!.data![index].firstName.toString(),
            child: Text(users!.data![index].firstName.toString() +
                " " +
                users!.data![index].lastName.toString())));
                
    emit(EmployeesLoaded());
  }

  getEmployeesWithServiceId(int? serviceId) async {
    users = await userService.GetEmployeeWithServiceByServiceId(serviceId);
    if (users!.data!.isNotEmpty) {
     
      setItems();
       await Future.delayed(Duration(milliseconds: 500));
        emit(EmployeesLoaded());
    }

   
  }

  getAllServices() async {
    _changeLoading();
    data = await service.getAll();
    if (data is ServiceModel) {
      this.data = data;
      emit(CustomerMainViewLoadingComplated());
    }

    _changeLoading();
  }
}

class CustomerMainViewState {}

class CustomerMainViewInitial extends CustomerMainViewState {}

class CustomerMainViewLoadingState extends CustomerMainViewState {}

class CustomerMainViewLoadingComplated extends CustomerMainViewState {}

class EmployeesLoaded extends CustomerMainViewState {}
