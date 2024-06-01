import 'dart:io';

import 'package:beautfy_center/model/reservation/add_reservation_model.dart';
import 'package:beautfy_center/model/reservation/getallreservationdetailresponse.dart';
import 'package:beautfy_center/model/service/service_model.dart';
import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:beautfy_center/services/IReservationService.dart';
import 'package:beautfy_center/services/IServiceService.dart';
import 'package:dio/dio.dart';

class ReservationService extends IReservationService {
  ReservationService(Dio dio) : super(dio);

  @override
  Future<void> add(AddReservationRequestModel model) async {
    final response = await dio.post("/Reservations/Add",data: model.toJson());
  }

  @override
  Future<GetAllReservationDetailResponseModel?> getAllDetails() async {
   final response = await dio.get("/Reservations/GetAllReservationDetailDto");
    if (response.statusCode == HttpStatus.ok) {
      return GetAllReservationDetailResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
  
  @override
  Future<void> deleteReservation(int? id) async {
     final response = await dio.post("/Reservations/Delete",queryParameters: {
      "id":id
     });
  }
  
  @override
  Future<GetAllReservationDetailResponseModel?> getAllDetailsByCustomerId(int? id) async {
    final response = await dio.get("/Reservations/GetAllReservationDetailByCustomerId", queryParameters: {
      "customerId":id
    });
    if (response.statusCode == HttpStatus.ok) {
      return GetAllReservationDetailResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
  
  @override
  Future<GetAllReservationDetailResponseModel?> getAllDetailsByEmployeeId(int? id) async {
  final response = await dio.get("/Reservations/GetAllReservationDetailByEmployeeId", queryParameters: {
      "employeeId":id
    });
    if (response.statusCode == HttpStatus.ok) {
      return GetAllReservationDetailResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
