import 'dart:io';

import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoginFail = false;
  final IUserService service;
  bool isLoading = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  RegisterCubit({required this.service}) : super(LoginInitial());

  Future<void> registerUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      if (_image == null) {
        pickImage(ImageSource.gallery);
      }
      else{
      final data = await service.register(UserRegisterModel(
          email: emailController.text.trim(),
          name: nameController.text.trim(),
          surname: surnameController.text.trim(),
          password: passwordController.text.trim()), _image);

      if (data is UserRegisterResponseModel) {
        if (data.success == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("user_id");
          await prefs.setInt("user_id", data.data!.id!.toInt());
          emit(RegisterComplate(true));
        }
      }
      await Future.delayed(Duration(seconds: 1));
      changeLoadingView();
    } }else {
      
    }
  }
  
  void changeLoadingView() {
    isLoading = !isLoading;
    emit(RegisterLoadingState(isLoading));
  }
}

abstract class RegisterState {}

class LoginInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {
  final bool isLoading;
  RegisterLoadingState(this.isLoading);
}
class RegisterComplate extends RegisterState {
  final bool isComplated;
  RegisterComplate(this.isComplated);
}
