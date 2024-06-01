import 'package:beautfy_center/admin/admin_add_employee_cubit.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/services/ServiceService.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddEmployeView extends StatelessWidget with DioMixinClass {
  AdminAddEmployeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminAddEmployeCubit(
          serviceService: ServiceService(service),
          service: UserService(service)),
      child: BlocConsumer<AdminAddEmployeCubit, AdminAddEmployeState>(
        listener: (context, state) {
          if (state is AdminAddEmployeServiceAdded) {
             WidgetsBinding.instance?.addPostFrameCallback((_) {
              _serviceAddPopup(context);
            });
          }
          if (state is AdminAddEmployeAdded) {
             WidgetsBinding.instance?.addPostFrameCallback((_) {
              _customerAdded(context);
            });
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Text(
                    "Add Employee",
                    style: Theme.of(context).textTheme.headlineLarge,
                  )),
                  Form(
                      key: context.watch<AdminAddEmployeCubit>().formKey,
                      child: Column(
                        children: [
                          _buildImagePickButton(context),
                          buildNameField(context),
                          buildSurnameField(context),
                          buildTextFormFieldLogin(context),
                          buildTextFormFieldPassword(context),
                          _buildRegisterButton(context)
                        ],
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                      child: Text(
                    "Add Service",
                    style: Theme.of(context).textTheme.headlineLarge,
                  )),
                  Form(
                      child: Column(
                    children: [
                      _buildImagePickButton(context),
                      _buildServiceName(context),
                      _buildAddService(context)
                    ],
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ElevatedButton _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          _areYouSureCancel(context);
        },
        child: Text(
          "Confirm",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ));
  }

  ElevatedButton _buildAddService(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          _areYouSureCancelAdd(context);
        },
        child: Text(
          "Confirm",
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
          context.read<AdminAddEmployeCubit>().pickImage(ImageSource.gallery);
        },
        child: Text(
          "Upload Photo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ));
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
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
        controller: context.watch<AdminAddEmployeCubit>().passwordController,
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
        controller: context.watch<AdminAddEmployeCubit>().emailController,
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
        controller: context.watch<AdminAddEmployeCubit>().surnameController,
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
        controller: context.watch<AdminAddEmployeCubit>().nameController,
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

  Padding _buildServiceName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<AdminAddEmployeCubit>().nameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.person),
            hintText: "Service Name"),
      ),
    );
  }

  Padding _imagePathField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<AdminAddEmployeCubit>().imagePathController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.image),
            hintText: "Image Path"),
      ),
    );
  }

  _areYouSureCancel(BuildContext context2) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context2.read<AdminAddEmployeCubit>().registerUserModel();
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
              child: const Text("Are you sure you want to add new employeer?."),
            ),
          );
        });
  }

  _areYouSureCancelAdd(BuildContext context2) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context2.read<AdminAddEmployeCubit>().addService();
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
              child: const Text("Are you sure you want to add new service?."),
            ),
          );
        });
  }

  _serviceAddPopup(BuildContext context2) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"))
            ],
            title: const Text("Successfull!"),
            content: Container(
              child: const Text("Service added successfully."),
            ),
          );
        });
  }
  _customerAdded(BuildContext context2) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"))
            ],
            title: const Text("Successfull!"),
            content: Container(
              child: const Text("Employeer added successfully."),
            ),
          );
        });
  }
}
