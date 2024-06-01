import 'package:beautfy_center/admin/admin_bottom_navigation_bar.dart';
import 'package:beautfy_center/auth/login_cubit.dart';
import 'package:beautfy_center/auth/register_view.dart';
import 'package:beautfy_center/bottom_navigation/bottom_navgation_bar.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/employeer/employeer_bottom_navigation.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget with DioMixinClass {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(service: UserService(service)),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginComplate) {
            if (state.model.data!.isAdmin == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdminNavigationBarView(null)));
            } else if (state.model.data!.isEmployee == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeerNavigationBarView(null)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarView(null)));
            }
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: context.watch<LoginCubit>().isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/background.jpg"))),
              child: Form(
                key: context.watch<LoginCubit>().formKey,
                autovalidateMode: state is LoginValidateState
                    ? (state.isValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled)
                    : AutovalidateMode.disabled,
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

                    Column(
                      children: [
                        Container(
                          width: 200,
                          child: Image(image: AssetImage("assets/images/logo.png"),),
                        ),
                        buildTextFormFieldLogin(context),
                        buildTextFormFieldPassword(context),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              context.read<LoginCubit>().postUserModel();
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )),
                        Text(
                          "Or",
                          style: TextStyle(),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterView()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Padding buildTextFormFieldPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        obscureText: true,
        controller: context.watch<LoginCubit>().passwordController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.lock),
            hintText: "Password"),
      ),
    );
  }

  Padding buildTextFormFieldLogin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<LoginCubit>().emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.email),
            hintText: "Email"),
      ),
    );
  }
}
