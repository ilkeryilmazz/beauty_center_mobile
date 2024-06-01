import 'package:beautfy_center/admin/admin_add_employee_view.dart';
import 'package:beautfy_center/admin/admin_all_reservation_view.dart';
import 'package:beautfy_center/admin/admin_employee_view.dart';
import 'package:beautfy_center/core/Cache/shared_manager.dart';
import 'package:beautfy_center/customer/customer_employees_view.dart';
import 'package:beautfy_center/customer/customer_main_view.dart';
import 'package:beautfy_center/customer/customer_profile_view.dart';
import 'package:beautfy_center/employeer/employee_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeerNavigationBarView extends StatefulWidget {
  int? newIndex;

  EmployeerNavigationBarView(this.newIndex, {super.key});

  @override
  State<EmployeerNavigationBarView> createState() =>
      _EmployeerNavigationBarViewState(this.newIndex);
}
int? id;
init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  id = sharedPreferences.getInt("user_id");
}
@override

class _EmployeerNavigationBarViewState
    extends State<EmployeerNavigationBarView> {
      void initState() {
    init();
    super.initState();
  }
  int _currentIndex = 0;
  List<Widget> _body = <Widget>[
    EmployeeProfileView(),
    AdminAllReservationView(id)
  ];
  int? newIndex;
  _EmployeerNavigationBarViewState(this.newIndex);

  @override
  Widget build(BuildContext context) {
    if (this.newIndex != null) {
      _currentIndex = newIndex!.toInt();
      newIndex = null;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          print(newIndex);
          setState(() {
            _currentIndex = newIndex;
          });
        },
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 14),
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.emoji_people,
                color: Colors.white,
              ),
              label: "Reservations"),
        ],
      ),
      body: _body[_currentIndex],
    );
  }
}
