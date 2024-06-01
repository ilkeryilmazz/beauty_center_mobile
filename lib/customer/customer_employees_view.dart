import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/customer/customer_employees_cubit.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerEmployeesView extends StatelessWidget with DioMixinClass {
  CustomerEmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerEmployeesCubit(service: UserService(service)),
      child: BlocConsumer<CustomerEmployeesCubit, CustomerEmployeesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return context.read<CustomerEmployeesCubit>().isLoading == true
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
                        ),    SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: context
                                  .read<CustomerEmployeesCubit>()
                                  .data!
                                  .data!
                                  .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(
                                      right: 20, left: 20, bottom: 20, top: 20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  color: Colors.pink.shade200,
                                  child: ListTile(
                                    leading: Image(
                                      image: NetworkImage(imagePath +
                                          context
                                              .read<CustomerEmployeesCubit>()
                                              .data!
                                              .data![index]
                                              .imagePath
                                              .toString()),
                                    ),
                                    title: Text(context
                                            .read<CustomerEmployeesCubit>()
                                            .data!
                                            .data![index]
                                            .firstName
                                            .toString() +
                                        " " +
                                        context
                                            .read<CustomerEmployeesCubit>()
                                            .data!
                                            .data![index]
                                            .lastName
                                            .toString()),
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
}
