// ignore_for_file: file_names, prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mess/Screens/ScreenWidgets/complaintM.dart';
import 'package:mess/widgets/GBottomNavBar.dart';

import 'ScreenWidgets/complaint.dart';
import 'ScreenWidgets/home.dart';
import 'ScreenWidgets/menu.dart';
import 'ScreenWidgets/profile.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name = "unknown";
  String role = "Faculty";
  void getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final currentUserData =
        await FirebaseFirestore.instance.doc('users/' + uid!).get();

    name = currentUserData['name'];
    role = currentUserData['role'];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    MenuPage(),
    Complaint(), //ComplaintM(),
    Profile(),
  ];

  static const TextStyle TitleStyle = TextStyle(color: Colors.white);

  static List<Widget> _widgetNames = <Widget>[
    Text(
      "Home",
      style: TitleStyle,
    ),
    Text(
      "Menu",
      style: TitleStyle,
    ),
    Text(
      "Complaint",
      style: TitleStyle,
    ),
    Text(
      "Profile",
      style: TitleStyle,
    ),
  ];

  void _manageSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Home(),
      MenuPage(),
      role == 'Mess Manager' ? ComplaintM() : Complaint(),
      Profile(),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF003366),
            Color(0xFF000A12),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.h),
          child: AppBar(
            backgroundColor: Color.fromARGB(0, 154, 37, 37),
            title: Column(
              children: [
                SizedBox(height: 15.h),
                _widgetNames.elementAt(_selectedIndex),
              ],
            ),
            toolbarHeight: 40.h,
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar:
            GbottomNavBar(manageSelectedIndex: _manageSelectedIndex),
      ),
    );
  }
}
