import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutridiet/Account/Login.dart';
import 'package:nutridiet/Admin/Profile.dart';
import 'package:nutridiet/BusinessLogic/Firebase.dart';
import 'package:nutridiet/Home/SubPages/Kitchen.dart';
import 'package:nutridiet/Home/SubPages/Profile.dart';
import 'package:nutridiet/Home/SubPages/Recipe.dart';

import 'Items.dart';
import 'Kitchen.dart';

final GlobalKey<ScaffoldState> customKey = GlobalKey();

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: customKey,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff0F1B2E)),
                color: Color(0xff454B60)
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              enableFeedback: false,
              selectedItemColor: Color(0xff70B5FF),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.transparent,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.edit_note),
                  label: 'Recipes',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.shopping_bag_outlined),
                  label: 'Items',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.verified_user_outlined),
                  label: 'Admin',
                ),
              ],
            ),
          ),
          body: Material(
            child: IndexedStack(index: _currentIndex, children: <Widget>[
              Visibility(visible: _currentIndex == 0,
                  child: AdminKitchen()
              ),
              Visibility(visible: _currentIndex == 1,
                  child: AdminItems()
              ),
              Visibility(visible: _currentIndex == 2,
                  child: AdminProfile()
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
