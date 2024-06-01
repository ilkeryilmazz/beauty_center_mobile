import 'dart:io';

import 'package:beautfy_center/model/user/employee_with_serviceid_model.dart';
import 'package:beautfy_center/model/user/get_all_employees_response.dart';
import 'package:beautfy_center/model/user/get_user_profile_response.dart';
import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:dio/dio.dart';

abstract class IUserService {
  final Dio dio;

  IUserService(this.dio);

  Future<UserLoginResponseModel?> postUserLogin(UserLoginModel model);
  Future<UserRegisterResponseModel?> register(
      UserRegisterModel model, File? File);
  Future<UserRegisterResponseModel?> Update(
      UserRegisterModel model, File? File);
  Future<UserRegisterResponseModel?> registerEmployee(
      UserRegisterModel model, File? File);
  Future<EmployeeWithServiceIdResponse?> GetEmployeeWithServiceByServiceId(
      int? serviceId);
  Future<GetUserProfileResponse?> GetUserProfileById(int? id);
  Future<void> Delete(int? id);
  Future<GetAllEmployesResponse?> GetAllEmployes();
}
