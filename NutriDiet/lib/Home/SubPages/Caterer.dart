import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:flutter/material.dart';
import 'package:nutridiet/Home/SubPages/Dietary.dart';
import 'package:nutridiet/Home/SubPages/Feedback.dart';
import 'package:nutridiet/Home/SubPages/Logging.dart';
import 'package:nutridiet/Home/SubPages/FoodPlanner.dart';

import '../../Account/Login.dart';
import '../../Account/SetupWizard.dart';
import '../../BusinessLogic/Firebase.dart';
import 'AddRecipe.dart';
import 'Cart.dart';
import 'FoodPlanner.dart';

bool userGender = true;
double userAge = 0;
double userHeight = 0;
double userWeight = 0;
double userBMR = 0;
String userGoal = "";

class Caterer extends StatefulWidget {
  const Caterer({super.key});

  @override
  State<Caterer> createState() => _subHomeState();
}

class _subHomeState extends State<Caterer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text(
                      "Welcome, ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                    Text(
                      FirebaseManager.user!.displayName!,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "NutriDiet - One Stop App for Healthy Recipe",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50,),
                Divider(),
                SizedBox(height: 20,),
                CommentBox("Anonymous", "12\$", "Just purchased 1 x item - Chicken Biryani"),
                SizedBox(height: 20,),
                CommentBox("Anonymous", "20\$", "Just purchased 2 x item - Sausage Burger"),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseManager.logoutAccount();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            color: Color(0xff454B60),
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Logout", style: TextStyle(fontSize: 16, color: Colors.white),),
                      ),
                    ),
                    Spacer(),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  CommentBox(String name, String price, String comment) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Icon(Icons.person, color: Colors.white, size: 24,),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(name,
                      style: TextStyle(
                          color: Color(0xff3D4048),
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(
                      child: Text(price,
                        style: TextStyle(
                          color: Color(0xff3D4048),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(
                      child: Text(comment,
                        style: TextStyle(
                          color: Color(0xff3D4048),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
