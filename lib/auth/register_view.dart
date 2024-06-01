import 'dart:io';

import 'package:beautfy_center/auth/login_cubit.dart';
import 'package:beautfy_center/auth/login_view.dart';
import 'package:beautfy_center/auth/register_cubit.dart';
import 'package:beautfy_center/bottom_navigation/bottom_navgation_bar.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatelessWidget with DioMixinClass {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(service: UserService(service)),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterComplate) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomNavigationBarView(null)));
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, RegisterState state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: context.watch<RegisterCubit>().isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/background.jpg"))),
              child: Form(
                key: context.read<RegisterCubit>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        "Beauty App",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                      Container(
                          width: 150,
                          child: Image(image: AssetImage("assets/images/logo.png"),),
                        ),
                    Column(
                      children: [
                        _buildImagePickButton(context),
                        buildNameField(context),
                        buildSurnameField(context),
                        buildTextFormFieldLogin(context),
                        buildTextFormFieldPassword(context),
                      ],
                    ),
                    Column(
                      children: [
                        _buildRegisterButton(context),
                        Text(
                          "Or",
                          style: TextStyle(),
                        ),
                        _buildLoginButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  ElevatedButton _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          context.read<RegisterCubit>().registerUserModel();
        },
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ));
  }

  ElevatedButton _buildImagePickButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          context.read<RegisterCubit>().pickImage(ImageSource.gallery);
        },
        child: Text(
          "Profil Resmini Yükle",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ));
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
        },
        child: Text(
          "Log In",
          style: TextStyle(),
        ));
  }

  Padding buildTextFormFieldPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        obscureText: true,
        controller: context.watch<RegisterCubit>().passwordController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.lock),
            hintText: "Password."),
      ),
    );
  }

  Padding buildTextFormFieldLogin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<RegisterCubit>().emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.email),
            hintText: "Email."),
      ),
    );
  }

  Padding buildSurnameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<RegisterCubit>().surnameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.person),
            hintText: "Surname."),
      ),
    );
  }

  Padding buildNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<RegisterCubit>().nameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.person),
            hintText: "Name"),
      ),
    );
  }
}
