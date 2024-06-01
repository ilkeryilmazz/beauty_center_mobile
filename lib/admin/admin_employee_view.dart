import 'package:beautfy_center/admin/admin_employee_cubit.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminEmployeeView extends StatelessWidget with DioMixinClass {
  AdminEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminEmployeeCubit(service: UserService(service)),
      child: BlocConsumer<AdminEmployeeCubit, AdminEmployeeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return context.read<AdminEmployeeCubit>().isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Employees",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: context
                                  .read<AdminEmployeeCubit>()
                                  .data!
                                  .data!
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.pink.shade300,
                                    ),
                                    padding: EdgeInsets.only(
                                        right: 20, left: 20, bottom: 20, top: 20),
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: ListTile(
                                      trailing: SizedBox(
                                        width: 53,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {

                                                  _areYouSureCancel(context, context
                                                          .read<
                                                              AdminEmployeeCubit>()
                                                          .data!
                                                          .data![index]
                                                          .id);
                                                
                                                },
                                                icon: Icon(Icons.remove)),
                                          ],
                                        ),
                                      ),
                                      leading: ClipRRect(
                                          child: CircleAvatar(
                                        backgroundImage: NetworkImage(imagePath +
                                            context
                                                .read<AdminEmployeeCubit>()
                                                .data!
                                                .data![index]
                                                .imagePath
                                                .toString()),
                                      )),
                                      title: Text(context
                                              .read<AdminEmployeeCubit>()
                                              .data!
                                              .data![index]
                                              .firstName
                                              .toString() +
                                          " " +
                                          context
                                              .read<AdminEmployeeCubit>()
                                              .data!
                                              .data![index]
                                              .lastName
                                              .toString()),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
    _areYouSureCancel(BuildContext context2, int? id) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    context2.read<AdminEmployeeCubit>().delete(id);
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
              child: const Text("Are you sure you want to delete your reservation?."),
            ),
          );
        });
}
}
