import 'dart:io';

import 'package:beautfy_center/model/service/service_add.dart';
import 'package:beautfy_center/model/service/service_model.dart';
import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:dio/dio.dart';

abstract class IServiceService{
  final Dio dio;

  IServiceService(this.dio);
  
  Future<ServiceModel?> getAll();
  Future<void> addService(ServiceAddModel model, File? file);
  }