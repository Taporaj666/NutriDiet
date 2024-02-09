import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutridiet/Account/Login.dart';
import 'package:nutridiet/BusinessLogic/Firebase.dart';
import 'package:nutridiet/Home/SubPages/Kitchen.dart';
import 'package:nutridiet/Home/SubPages/Profile.dart';
import 'package:nutridiet/Home/SubPages/Recipe.dart';

import 'SubPages/AddRecipe.dart';
import 'SubPages/Search.dart';
import 'SubPages/SubHome.dart';

final GlobalKey<ScaffoldState> customKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
                  icon: new Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.screen_search_desktop_outlined),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.cookie_outlined),
                  label: 'Kitchen',
                ),
                BottomNavigationBarItem(
                  icon: new Icon(Icons.person_outlined),
                  label: 'Profile',
                ),
              ],
            ),
          ),
          body: Material(
            child: IndexedStack(index: _currentIndex, children: <Widget>[
              Visibility(visible: _currentIndex == 0,
                  child: subHome()
              ),
              Visibility(visible: _currentIndex == 1,
                  child: searchPage()
              ),
              Visibility(visible: _currentIndex == 2,
                  child: Kitchen()
              ),
              Visibility(visible: _currentIndex == 3,
                  child: Profile()
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
