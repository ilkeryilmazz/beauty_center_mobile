import 'package:beautfy_center/model/reservation/getallreservationdetailresponse.dart';
import 'package:beautfy_center/services/ReservationService.dart';
import 'package:bloc/bloc.dart';

class AdminAllReservationCubit extends Cubit<AdminAllReservationState> {
  GetAllReservationDetailResponseModel? data;
  ReservationService service;
  bool isLoading = false;
  int? employeeId;
  AdminAllReservationCubit({required this.employeeId, required this.service})
      : super(AdminAllReservationInitial()) {
    getAllDetails();
  }

  getAllDetails() async {
    if (employeeId != null) {
      changeLoading();
      getAllDetailsByEmployeeId();
      changeLoading();
    }
    changeLoading();
    data = await service.getAllDetails();
    changeLoading();
  }
  getAllDetailsByEmployeeId() async {
    data = await service.getAllDetailsByEmployeeId(employeeId);
  }
  changeLoading() {
    isLoading = !isLoading;
    emit(AdminAllReservationLoading());
  }

  delete(int? id) async {
    changeLoading();
    await service.deleteReservation(id);

    changeLoading();
    getAllDetails();
  }
}

class AdminAllReservationInitial extends AdminAllReservationState {}

class AdminAllReservationLoading extends AdminAllReservationState {}

class AdminAllReservationState {}
