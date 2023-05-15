import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'appointment.dart';
import 'main.dart';
import 'patient_dash.dart';
import 'patient_profi.dart';
import 'patient_report.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    ReportScreen(),
   // AppointmentPage(),
    ProfilePage(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 93, 74, 74),
      //   centerTitle: true,
      //   title: Text("9th World Ranger"),
      // ),
      backgroundColor: Color.fromARGB(255, 142, 163, 148),
      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Color.fromARGB(255, 44, 73, 121),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 3, 4, 6),
        onTap: _onItemTapped,
      ),
    );
  }
}
