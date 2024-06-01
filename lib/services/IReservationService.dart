import 'dart:io';

import 'package:beautfy_center/model/reservation/add_reservation_model.dart';
import 'package:beautfy_center/model/reservation/getallreservationdetailresponse.dart';
import 'package:beautfy_center/model/service/service_add.dart';
import 'package:beautfy_center/model/service/service_model.dart';
import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:dio/dio.dart';

abstract class IReservationService{
  final Dio dio;

  IReservationService(this.dio);
  
  Future<void> add(AddReservationRequestModel model);
  
  Future<void> deleteReservation(int? id);
  Future<GetAllReservationDetailResponseModel?> getAllDetails();
  Future<GetAllReservationDetailResponseModel?> getAllDetailsByCustomerId(int? id);
    Future<GetAllReservationDetailResponseModel?> getAllDetailsByEmployeeId(int? id);
  }