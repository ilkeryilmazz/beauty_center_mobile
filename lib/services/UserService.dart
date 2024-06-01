import 'dart:io';

import 'package:beautfy_center/model/user/employee_with_serviceid_model.dart';
import 'package:beautfy_center/model/user/get_all_employees_response.dart';
import 'package:beautfy_center/model/user/get_user_profile_response.dart';
import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:dio/dio.dart';

class UserService extends IUserService {
  UserService(Dio dio) : super(dio);

//Kullanıcı girişinin sağlanması için api'a istek gönderen metod;
  @override
  Future<UserLoginResponseModel?> postUserLogin(UserLoginModel model) async {
    final response = await dio.post("/Users/Login", data: model.toJson());
    if (response.statusCode == HttpStatus.ok) {
      return UserLoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<UserRegisterResponseModel?> register(
      UserRegisterModel model, File? file) async {
    String fileName = file!.path.split('/').last;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file!.path, filename: fileName),
      "FirstName": model.name,
      "LastName": model.surname,
      "Email": model.email,
      "Password": model.password,
    });
    final response = await dio.post("/Users/Register", data: formData);
    if (response.statusCode == HttpStatus.ok) {
      return UserRegisterResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<EmployeeWithServiceIdResponse?> GetEmployeeWithServiceByServiceId(
      int? serviceId) async {
    final response = await dio.get("/Users/GetEmployeeWithServiceByServiceId",
        queryParameters: {"serviceId": serviceId});
    if (response.statusCode == HttpStatus.ok) {
      return EmployeeWithServiceIdResponse.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<GetUserProfileResponse?> GetUserProfileById(int? id) async {
    final response =
        await dio.get("/Users/GetById", queryParameters: {"id": id});
    if (response.statusCode == HttpStatus.ok) {
      return GetUserProfileResponse.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<GetAllEmployesResponse?> GetAllEmployes() async {
    final response = await dio.get(
      "/Users/GetAllEmployees",
    );
    if (response.statusCode == HttpStatus.ok) {
      return GetAllEmployesResponse.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<UserRegisterResponseModel?> registerEmployee(
      UserRegisterModel model, File? file) async {
    String fileName = file!.path.split('/').last;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file!.path, filename: fileName),
      "FirstName": model.name,
      "LastName": model.surname,
      "Email": model.email,
      "Password": model.password,
    });
    final response = await dio.post("/Users/RegisterEmployee", data: formData);
    if (response.statusCode == HttpStatus.ok) {
      return UserRegisterResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<void> Delete(int? id) async {
    final response =
        await dio.post("/Users/Delete", queryParameters: {"id": id});
  }

  @override
  Future<UserRegisterResponseModel?> Update(
      UserRegisterModel model, File? File) async {
   if (File != null) {
      String fileName = File!.path.split('/').last;
    var formData = FormData.fromMap({
      "id": model.id,
      'image':  await MultipartFile.fromFile(File!.path, filename: fileName),
      "FirstName": model.name,
      "LastName": model.surname,
      "Email": model.email,
      "Password": model.password,
    });
   }

    var formData = FormData.fromMap({
      "id": model.id,
    
      "FirstName": model.name,
      "LastName": model.surname,
      "Email": model.email,
      "Password": model.password,
    });
    final response = await dio.post("/Users/Update", data: formData);
    if (response.statusCode == HttpStatus.ok) {
      return UserRegisterResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
