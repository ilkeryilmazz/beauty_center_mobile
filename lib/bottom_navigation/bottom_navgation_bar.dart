import 'package:beautfy_center/core/Cache/shared_manager.dart';
import 'package:beautfy_center/customer/customer_employees_view.dart';
import 'package:beautfy_center/customer/customer_main_view.dart';
import 'package:beautfy_center/customer/customer_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigationBarView extends StatefulWidget {
  int? newIndex;

  BottomNavigationBarView(this.newIndex, {super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState(this.newIndex);
}
SharedManager? shared;
class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  
  initShared() {
    shared = SharedManager();
    shared!.init();
  }

  @override
  void initState() {
    initShared();
    super.initState();
    
  }

  int _currentIndex = 0;
  List<Widget> _body = <Widget>[
    CustomerMainView(),
    CustomerEmployeesView(),
    CustomerProfileView(shared: shared,)
  ];
  int? newIndex;
  _BottomNavigationBarViewState(this.newIndex);

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
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.emoji_people,
                color: Colors.white,
              ),
              label: "Employees"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: "Profile")
        ],
      ),
      body: _body[_currentIndex],
    );
  }
}
