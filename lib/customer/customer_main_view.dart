import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/customer/customer_main_view_cubit.dart';
import 'package:beautfy_center/customer/customer_reservation_view.dart';
import 'package:beautfy_center/services/ServiceService.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerMainView extends StatelessWidget with DioMixinClass {
  CustomerMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerMainViewCubit(
          userService: UserService(service), service: ServiceService(service)),
      child: BlocConsumer<CustomerMainViewCubit, CustomerMainViewState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return context.watch<CustomerMainViewCubit>().isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  body: Card(
                  child: GridView.builder(
                      itemCount: context
                          .watch<CustomerMainViewCubit>()
                          .data!
                          .data!
                          .length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (newContext) => CustomerReservationView(context.read<CustomerMainViewCubit>().data!.data![index].id)));
                          },
                          child: Card(
                            color: Colors.pink.shade300,
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: Image(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                          imagePath+
                                          context
                                            .read<CustomerMainViewCubit>()
                                            .data!
                                            .data![index]
                                            .imagePath
                                            .toString()))),
                                Padding(padding: EdgeInsets.only(bottom: 15)),
                                Text(
                                  context
                                      .read<CustomerMainViewCubit>()
                                      .data!
                                      .data![index]
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ));
        },
      ),
    );
  }

  _addReservationModel(BuildContext context2, int? index) {
    return showDialog<void>(
        context: context2,
        builder: (BuildContext context) {
          context2
              .watch<CustomerMainViewCubit>()
              .getEmployeesWithServiceId(index);
          return StatefulBuilder(
            builder: (context, setState) {
              
           
            return AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        //context2.read<CustomerMainViewCubit>()
                      },
                      child: const Text("Kaydet")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Kapat"))
                ],
                title: const Text("Rezarvasyon Ekle!"),
                content: Container(
                  height: 200,
                  child: Column(
                    children: [
                    
                    ],
                  ),
                ));
                
        });
        });
  }

  Padding _buildDatePicker(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<CustomerMainViewCubit>().dateController,
        onTap: () async {
          await _selectDate(context);
          await _selectTime(context);
        },
        readOnly: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            prefixIcon: Icon(Icons.date_range),
            hintText: "Tarih seç"),
      ),
    );
  }

  Padding _buildSelectEmployee(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 20),
        child: DropdownButton<String>(
          value: context.watch<CustomerMainViewCubit>().selectedEmployee,
          items: context.watch<CustomerMainViewCubit>().dropdownItems,
          onChanged: (value) {
            context.read<CustomerMainViewCubit>().selectedEmployee = value;
          },
        ));
  }

  _selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if (_picked != null) {
      context.read<CustomerMainViewCubit>().dateController.text =
          _picked.toString().split(" ")[0];
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? _picked = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
    if (_picked != null) {
      context.read<CustomerMainViewCubit>().timeController.text =
          _picked.toString().split(" ")[0];
    }
  }
}
