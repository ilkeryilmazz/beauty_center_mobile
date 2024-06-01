import 'dart:io';

import 'package:beautfy_center/model/user/get_user_profile_response.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfileCubit extends Cubit<EmployeeProfileState> {
  IUserService service;
  GetUserProfileResponse? data;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  updateUser() {}
  changeLoading() {
    isLoading = !isLoading;
    emit(EmployeeProfileLoading());
  }

  getProfile() async {
    changeLoading();
    SharedPreferences shared = await SharedPreferences.getInstance();

    int? id = shared.getInt("user_id");
    data = await service.GetUserProfileById(id);
    changeLoading();
  }

  EmployeeProfileCubit({required this.service})
      : super(EmployeeProfileInitial()) {
    getProfile();
  }

  Future<void> update() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoading();
      
        SharedPreferences preferences = await SharedPreferences.getInstance();
        int? id = preferences.getInt("user_id");
        final data = await service.Update(
            UserRegisterModel(
                id: id,
                email: emailController.text.trim(),
                name: nameController.text.trim(),
                surname: surnameController.text.trim(),
                password: passwordController.text.trim()),
            image );

        await Future.delayed(Duration(seconds: 1));
        emailController.clear();
        nameController.clear();
        passwordController.clear();
        surnameController.clear();
        changeLoading();
      }
    }
  
}

class EmployeeProfileInitial extends EmployeeProfileState {}

class EmployeeProfileLoading extends EmployeeProfileState {}

class EmployeeProfileState {}
