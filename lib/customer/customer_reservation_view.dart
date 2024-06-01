import 'package:beautfy_center/core/Dio/DioMixin.dart';
import 'package:beautfy_center/customer/customer_reservation_cubit.dart';
import 'package:beautfy_center/services/ReservationService.dart';
import 'package:beautfy_center/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerReservationView extends StatelessWidget with DioMixinClass {
  int? serviceId;
  CustomerReservationView(this.serviceId);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerReservationCubit(
          reservationService: ReservationService(service),
          serviceId: serviceId,
          userService: UserService(service)),
      child: BlocConsumer<CustomerReservationCubit, CustomerReservationState>(
        listener: (context, state) {
          if (state is CustomerReservationAdded) {
             WidgetsBinding.instance?.addPostFrameCallback((_) {
              _customerAdded(context);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink.shade300,
            ),
            body: context.watch<CustomerReservationCubit>().isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create a reservation",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _buildSelectEmployee(context),
                      _buildDatePicker(context),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {
                            context
                                .read<CustomerReservationCubit>()
                                .addReservation();
                          },
                          child: Text(
                            "Create a reservation",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Padding _buildDatePicker(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: context.watch<CustomerReservationCubit>().dateController,
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
        child: Container(
          width: MediaQuery.of(context).size.width - 75,
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            iconEnabledColor: Colors.pink.shade300,
            value: context.watch<CustomerReservationCubit>().selectedEmployee,
            items: context.watch<CustomerReservationCubit>().dropdownItems,
            onChanged: (value) {
              context
                  .read<CustomerReservationCubit>()
                  .changeSelectedValue(value);
            },
          ),
        ));
  }

  DateTime? _pickedDate;
  _selectDate(BuildContext context) async {
    _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if (_pickedDate != null) {
      context.read<CustomerReservationCubit>().dateController.text =
          _pickedDate.toString().split(" ")[0];
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? _picked = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
    if (_picked != null) {
      context.read<CustomerReservationCubit>().timeController.text =
          _picked.toString().split(" ")[0];
      context.read<CustomerReservationCubit>().setTime(_picked, _pickedDate);
    }
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
              child: const Text("Reservation added successfully."),
            ),
          );
        });
  }
}
