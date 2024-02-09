import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:flutter/material.dart';
import 'package:nutridiet/Home/SubPages/Dietary.dart';
import 'package:nutridiet/Home/SubPages/Feedback.dart';
import 'package:nutridiet/Home/SubPages/Logging.dart';
import 'package:nutridiet/Home/SubPages/FoodPlanner.dart';

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
String actualUserBMR = "";
String userGoal = "";
String userHealth = "";
String userExercise = "";

class subHome extends StatefulWidget {
  const subHome({super.key});

  @override
  State<subHome> createState() => _subHomeState();
}

class _subHomeState extends State<subHome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateBMI();
  }

  calculateBMI() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userData = await nutriBase.getUserData();
    print(userData);
    print(userData.toString());
    if (userData.length == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SetupWizard()),
      );
    }
    userGender = userData[0].data()["gender"] == "Male";
    userAge = double.parse(userData[0].data()["age"]);
    userHeight = double.parse(userData[0].data()["height"]);
    userWeight = double.parse(userData[0].data()["weight"]);
    userGoal = userData[0].data()["goal"];
    userHealth = userData[0].data()["health_issue"];
    userExercise = userData[0].data()["workout"];
    String userWorkout = userData[0].data()["workout"];
    userBMR = nutriBase.calculateBMR(userGender, userWeight, userHeight, userAge);
    actualUserBMR = biasGenerator(workoutCheck(userWorkout), userGoal);
  }

  biasGenerator(double bias, String goal) {
    double weightedBMR = userBMR * bias;

    if (goal == "Gain") {
      weightedBMR += 500;
    }
    else if (goal == "Lose") {
      weightedBMR -= 500;
    }
    else if (goal == "Maintain") {
      weightedBMR += 0;
    }

    return weightedBMR.toStringAsFixed(1);
  }

  workoutCheck(String goal) {
    if (goal == "")
      return 1.0;
    if (goal == "Sedentary Exercise")
      return 1.2;
    if (goal == "Light Exercise (1-2 Days a week)")
      return 1.375;
    if (goal == "Good Exercise (3-5 Days a week)")
      return 1.55;
    if (goal == "Hard Exercise (6-7 Days a week)")
      return 1.725;
    if (goal == "Extreme Exercise (2x Training)")
      return 1.9;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: menuBox("assets/logging.jpg", "Food Logging and Tracking", "Effortlessly track your daily nutrition with our Food Logging feature.", FoodLogging()),
                ),
                SizedBox(width: 30,),
                Expanded(
                  child: menuBox("assets/plan.jpg", "Meal Planning", "Effortlessly plan your meals for success with our Meal Planning feature.", FoodPlanner()),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: menuBox("assets/diet.jpg", "Dietary Assessment", "Gain personalized insights into your diet with our quick and easy Dietary Assessment. ", Dietary()),
                ),
                SizedBox(width: 30,),
                Expanded(
                  child: menuBox("assets/feedback.jpg", "User Feedback", "Use our User Feedback feature to suggest and rate healthy recipes. ", FeedBack()),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: menuBox("assets/recipe.jpg", " Insert Recipe", "Share your recipe with the world.", addRecipe()),
                ),
                SizedBox(width: 30,),
                Expanded(
                  child: menuBox("assets/cart.jpg", "Cart", "Add stuff you want to buy and keep track of it", Cart()),
                )
              ],
            ),
          ],
        )
      ),
    );
  }

  menuBox(String image, String title, String details, Widget forwarder) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => forwarder),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover),
            ),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
          ),
          Text(
            details,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200
            ),
          ),
        ],
      ),
    );
  }
}
