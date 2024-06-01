import 'package:beautfy_center/core/Cache/shared_manager.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/customer/customer_profile_cubit.dart';
import 'package:beautfy_center/employeer/employee_profile_cubit.dart';
import 'package:beautfy_center/services/ReservationService.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeProfileView extends StatelessWidget with DioMixinClass {
  EmployeeProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeProfileCubit(service: UserService(service)),
      child: BlocConsumer<EmployeeProfileCubit, EmployeeProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: context.watch<EmployeeProfileCubit>().isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Center(
                                child: Text(
                              "Welcome - " +
                                  context
                                      .read<EmployeeProfileCubit>()
                                      .data!
                                      .data!
                                      .firstName
                                      .toString(),
                              style: Theme.of(context).textTheme.headlineLarge,
                            )),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<EmployeeProfileCubit>()
                                      .pickImage(ImageSource.gallery);
                                },
                                child: CircleAvatar(
                                  minRadius: 75,
                                  maxRadius: 80,
                                  backgroundImage: context.read<EmployeeProfileCubit>().image !=null ? NetworkImage(
                                    scale: 1,
                                    imagePath +
                                        context
                                            .read<EmployeeProfileCubit>()
                                            .data!
                                            .data!
                                            .imagePath
                                            .toString(),
                                  ) : NetworkImage(
                                    scale: 1,
                                    imagePath +
                                        context
                                            .read<EmployeeProfileCubit>()
                                            .data!
                                            .data!
                                            .imagePath
                                            .toString(),
                                  ),
                                ),
                              ),
                            ),
                            Form(
                              key: context.watch<EmployeeProfileCubit>().formKey,
                              child: Column(children: [  buildNameField(context),
                            buildSurnameField(context),
                            buildTextFormFieldLogin(context),
                            buildTextFormFieldPassword(context),],)),
                          
                            _buildLoginButton(context),
                          ],
                        ),
                      ),
                    ));
        },
      ),
    );
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.read<EmployeeProfileCubit>().update();
        },
        child: Text(
          "Update",
          style: TextStyle(),
        ));
  }

  _areYouSureCancel(BuildContext context2, int? id) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    //context2.read<EmployeeProfileCubit>().delete(id);
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
            title: const Text("Are you sure!"),
            content: Container(
              child: const Text(
                  "Are you sure you want to delete your reservation?."),
            ),
          );
        });
  }

  Padding buildTextFormFieldPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        obscureText: true,
        controller: context.watch<EmployeeProfileCubit>().passwordController,
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
        controller: context.watch<EmployeeProfileCubit>().emailController,
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
        controller: context.watch<EmployeeProfileCubit>().surnameController,
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
        controller: context.watch<EmployeeProfileCubit>().nameController,
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
