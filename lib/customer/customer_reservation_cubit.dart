import 'package:beautfy_center/core/Cache/shared_manager.dart';
import 'package:beautfy_center/model/reservation/add_reservation_model.dart';
import 'package:beautfy_center/model/user/employee_with_serviceid_model.dart';
import 'package:beautfy_center/services/IReservationService.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CustomerReservationCubit extends Cubit<CustomerReservationState> {
  IUserService userService;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  EmployeeWithServiceIdResponse? users;
  int? serviceId;
  SharedManager? shared;
  IReservationService reservationService;
  DateTime? time;
  bool isLoading = false;
  List<DropdownMenuItem<String>>? dropdownItems = [
    DropdownMenuItem(child: Text("Bu hizmeti veren bir çalışanımız yok"))
  ];
  String? selectedEmployee;
  CustomerReservationCubit(
      {required this.reservationService,
      required this.serviceId,
      required this.userService})
      : super(CustomerReservationInitial()) {
    getEmployeesWithServiceId(serviceId);
    initShared();
  }
  initShared() {
    shared = SharedManager();
    shared!.init();
  }

  changeSelectedValue(value) {
    selectedEmployee = value.toString();
    emit(CustomerReservationLoading());
  }

  setTime(TimeOfDay? timeOfDay, DateTime? dateTime) {
    DateTime newDate = DateTime(dateTime!.year, dateTime.month, dateTime.day,
        timeOfDay!.hour, timeOfDay.minute);
    time = newDate;
  }

  setItems() {
    dropdownItems = List.generate(
        users!.data!.length,
        (index) => DropdownMenuItem(
            value: users!.data![index].id.toString(),
            child: Text(users!.data![index].firstName.toString() +
                " " +
                users!.data![index].lastName.toString())));
    selectedEmployee = dropdownItems![0].value.toString();
  }

  addReservation() async {
    int? id = shared!.getInt(SharedKeys.user_id);
    await reservationService.add(AddReservationRequestModel(
        id: 0,
        customerId: id,
        date: time!.toIso8601String(),
        serviceId: serviceId,
        status: false,
        employeeId: int.tryParse(selectedEmployee.toString())));
        emit(CustomerReservationAdded());
  }

  _changeLoading() {
    isLoading = !isLoading;
    emit(CustomerReservationState());
  }

  getEmployeesWithServiceId(int? serviceId) async {
    _changeLoading();
    users = await userService.GetEmployeeWithServiceByServiceId(serviceId);
    if (users!.data!.isNotEmpty) {
      setItems();
      await Future.delayed(Duration(milliseconds: 500));
    }
    _changeLoading();
  }
}

class CustomerReservationInitial extends CustomerReservationState {}

class CustomerReservationState {}

class CustomerReservationLoading extends CustomerReservationState {}
class CustomerReservationAdded extends CustomerReservationState {}
