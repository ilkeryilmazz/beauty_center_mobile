import 'package:beautfy_center/model/user/user_login_model.dart';
import 'package:beautfy_center/model/user/user_login_response_model.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoginFail = false;
  final IUserService service;
  bool isLoading = false;
  LoginCubit({required this.service}) : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      changeLoadingView();
      final data = await service.postUserLogin(UserLoginModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));

      if (data is UserLoginResponseModel) {
        if (data.success == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("user_id");
          await prefs.setInt("user_id", data.data!.id!.toInt());
          emit(LoginComplate(data));
        }
      }
      await Future.delayed(Duration(seconds: 1));
      changeLoadingView();
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {
  final bool isLoading;
  LoginLoadingState(this.isLoading);
}

class LoginComplate extends LoginState {
  final UserLoginResponseModel model;

  LoginComplate(this.model);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}
