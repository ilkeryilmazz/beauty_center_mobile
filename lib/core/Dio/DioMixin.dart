import 'package:dio/dio.dart';

mixin class DioMixinClass{
  final service = Dio(BaseOptions(baseUrl: "https://10.0.2.2:7214/api",receiveDataWhenStatusError: true));
  final imagePath="https://10.0.2.2:7214/uploads/images/";
}