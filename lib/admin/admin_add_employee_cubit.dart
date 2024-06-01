import 'dart:io';

import 'package:beautfy_center/model/service/service_add.dart';
import 'package:beautfy_center/model/user/user_register_model.dart';
import 'package:beautfy_center/model/user/user_register_response_model.dart';
import 'package:beautfy_center/services/IServiceService.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddEmployeCubit extends Cubit<AdminAddEmployeState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKey2 = GlobalKey();
  File? _image;
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  IUserService service;
  IServiceService serviceService;
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  AdminAddEmployeCubit({required this.serviceService, required this.service})
      : super(AdminAddEmployeInitial());

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(AddAdminLoadingState(isLoading));
  }

  addService() async {
    await this.serviceService.addService(
        ServiceAddModel(id: 0, imagePath: "", name: nameController.text),
        _image);
        emit(AdminAddEmployeServiceAdded());
  }

  Future<void> registerUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      if (_image == null) {
        pickImage(ImageSource.gallery);
      } else {
        final data = await service.registerEmployee(
            UserRegisterModel(
                email: emailController.text.trim(),
                name: nameController.text.trim(),
                surname: surnameController.text.trim(),
                password: passwordController.text.trim()),
            _image);

        await Future.delayed(Duration(seconds: 1));
        emailController.clear();
        nameController.clear();
        passwordController.clear();
        surnameController.clear();
        changeLoadingView();
        emit(AdminAddEmployeAdded());
      }
    }
  }
}

class AddAdminLoadingState extends AdminAddEmployeState {
  final bool isLoading;
  AddAdminLoadingState(this.isLoading);
}

class AdminAddEmployeInitial extends AdminAddEmployeState {}
class AdminAddEmployeServiceAdded extends AdminAddEmployeState {}
class AdminAddEmployeState {}

class AdminAddEmployeAdded extends AdminAddEmployeState{

}