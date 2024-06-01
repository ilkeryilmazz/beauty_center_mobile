import 'package:beautfy_center/admin/admin_all_reservation_cubit.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/services/ReservationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAllReservationView extends StatelessWidget with DioMixinClass {
  AdminAllReservationView( this.employeeId, {super.key});
  int? employeeId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminAllReservationCubit(employeeId: employeeId,service: ReservationService(service)),
      child: BlocConsumer<AdminAllReservationCubit, AdminAllReservationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return context.watch<AdminAllReservationCubit>().isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Reservations",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: context
                              .read<AdminAllReservationCubit>()
                              .data!
                              .data!
                              .length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.pink.shade300,
                                  borderRadius: BorderRadius.circular(10),
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
                                              _areYouSureCancel(context, context.read<AdminAllReservationCubit>().data!.data![index].id);
                                             
                                            },
                                            icon: Icon(Icons.remove)),
                                      ],
                                    ),
                                  ),
                                  title: context.read<AdminAllReservationCubit>().employeeId != null ? Text("Service Provider: " +
                                      "Me ") : Text("Service Provider: " +context.read<AdminAllReservationCubit>().data!.data![index].employeeName.toString().toUpperCase()),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Service User: " +
                                          context
                                              .read<AdminAllReservationCubit>()
                                              .data!
                                              .data![index]
                                              .customerName
                                              .toString()
                                              .toUpperCase()),
                                      Text("Date: " +
                                          context
                                              .read<AdminAllReservationCubit>()
                                              .data!
                                              .data![index]
                                              .date!
                                              .substring(0, 10)
                                              .toString()
                                              .toUpperCase()),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
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
                    context2.read<AdminAllReservationCubit>().delete(id);
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