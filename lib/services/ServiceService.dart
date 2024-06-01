import 'dart:io';

import 'package:beautfy_center/model/service/service_add.dart';
import 'package:beautfy_center/model/service/service_model.dart';
import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:beautfy_center/services/IServiceService.dart';
import 'package:dio/dio.dart';

class ServiceService extends IServiceService {
  ServiceService(Dio dio) : super(dio);

  @override
  Future<ServiceModel?> getAll() async {
    final response = await dio.get("/Services/GetAll");
    if (response.statusCode == HttpStatus.ok) {
      return ServiceModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  @override
  Future<void> addService(ServiceAddModel model, File? File) async {
    if (File != null) {
      String fileName = File!.path.split('/').last;
      var formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(File!.path, filename: fileName),
        "Name": model.name,
        "ImagePath": "d",
      });
       final response = await dio.post("/Services/Add", data: formData);
    }
   
  }
}
