import 'package:beautfy_center/core/Cache/shared_manager.dart';
import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/customer/customer_profile_cubit.dart';
import 'package:beautfy_center/services/ReservationService.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProfileView extends StatelessWidget with DioMixinClass {
  SharedManager? shared;
  CustomerProfileView({required this.shared, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerProfileCubit(reservationService: ReservationService(service),service: UserService(service)),
      child: BlocConsumer<CustomerProfileCubit, CustomerProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: context.watch<CustomerProfileCubit>().isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 25,),
                        Center(
                            child: Text(
                          "Welcome - " +
                              context
                                  .read<CustomerProfileCubit>()
                                  .data!
                                  .data!
                                  .firstName
                                  .toString(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        )),
                        
                        Container(
                          child: CircleAvatar(
                            minRadius: 75,
                            maxRadius: 80,
                            
                            backgroundImage: NetworkImage(scale: 1,
                              imagePath +
                                  context
                                      .read<CustomerProfileCubit>()
                                      .data!
                                      .data!
                                      .imagePath
                                      .toString(),
                            ),
                          ),
                        ),
                         SizedBox(height: 25,),
                        Expanded(
                      child: ListView.builder(
                          itemCount: context
                              .read<CustomerProfileCubit>()
                              .reservations!
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
                                              _areYouSureCancel(context, context.read<CustomerProfileCubit>().reservations!.data![index].id);
                                            
                                            },
                                            icon: Icon(Icons.remove)),
                                      ],
                                    ),
                                  ),
                                  title: Text("Hizmet veren: " +
                                      context
                                          .read<CustomerProfileCubit>()
                                          .reservations!
                                          .data![index]
                                          .employeeName
                                          .toString()
                                          .toUpperCase()),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Servis: " +
                                          context
                                              .read<CustomerProfileCubit>()
                                              .reservations!
                                              .data![index]
                                              .service
                                              .toString()
                                              .toUpperCase()),
                                      Text("Tarih: " +
                                          context
                                              .read<CustomerProfileCubit>()
                                              .reservations!
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
                    ));
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
                    context2.read<CustomerProfileCubit>().delete(id);
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
