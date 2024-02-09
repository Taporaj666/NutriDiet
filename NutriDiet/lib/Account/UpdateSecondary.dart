import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:nutridiet/Home/SubPages/SubHome.dart';

import '../BusinessLogic/Firebase.dart';
import '../Home/Home.dart';
import 'Login.dart';

class UpdateSecondary extends StatefulWidget {
  const UpdateSecondary({super.key});

  @override
  State<UpdateSecondary> createState() => _UpdateSecondaryState();
}

class _UpdateSecondaryState extends State<UpdateSecondary> {

  int goal = 0;
  int health = 0;
  int fitness = 0;

  bool readyState = true;

  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadDefaults();
  }

  loadDefaults() {
    setState(() {
      if (userHealth == "Hypertension") {
        health = 0;
      }
      else if (userHealth == "Lactose Intolerance") {
        health = 1;
      }
      else if (userHealth == "Cardiovascular Disease") {
        health = 2;
      }
      else if (userHealth == "Diabetes") {
        health = 3;
      }
      else if (userHealth == "None") {
        health = 4;
      }
      if (userGoal == "Gain") {
        goal = 0;
      }
      else if (userGoal == "Lose") {
        goal = 1;
      }
      else if (userGoal == "Maintain") {
        goal = 2;
      }
      if (userExercise == "Light Exercise (1-2 Days a week)") {
        fitness = 0;
      }
      else if (userExercise == "Good Exercise (3-5 Days a week)") {
        fitness = 1;
      }
      else if (userExercise == "Hard Exercise (6-7 Days a week)") {
        fitness = 2;
      }
      else if (userExercise == "Extreme Exercise (2x Training)") {
        fitness = 3;
      }
      else if (userExercise == "Sedentary Exercise") {
        fitness = 4;
      }
    });
  }

  getGoal() {
    if (goal == 0)
      return "Gain";
    if (goal == 1)
      return "Lose";
    if (goal == 2)
      return "Maintain";
  }

  getHealth() {
    if (health == 0)
      return "Hypertension";
    if (health == 1)
      return "Lactose Intolerance";
    if (health == 2)
      return "Cardiovascular Disease";
    if (health == 3)
      return "Diabetes";
    if (health == 4)
      return "None";
  }

  getFitness() {
    if (fitness == 0)
      return "Light Exercise (1-2 Days a week)";
    if (fitness == 1)
      return "Good Exercise (3-5 Days a week)";
    if (fitness == 2)
      return "Hard Exercise (6-7 Days a week)";
    if (fitness == 3)
      return "Extreme Exercise (2x Training)";
	if (fitness == 4)
      return "Sedentary Exercise";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  Spacer(),
                  Text("Setup Account", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
                  Spacer(),
                ],
              ),
              SizedBox(height: 40,),
              goalSetter(0, "Gain Weight"),
              SizedBox(height: 20,),
              goalSetter(1, "Lose Weight"),
              SizedBox(height: 20,),
              goalSetter(2, "Maintain Weight"),
              SizedBox(height: 40,),
              Divider(),
              SizedBox(height: 40,),
              healthSetter(4, "None"),
              SizedBox(height: 20,),
              healthSetter(0, "Hypertension"),
              SizedBox(height: 20,),
              healthSetter(1, "Lactose Intolerance"),
              SizedBox(height: 20,),
              healthSetter(2, "Cardiovascular Disease"),
              SizedBox(height: 20,),
              healthSetter(3, "Diabetes"),
              Divider(),
              SizedBox(height: 40,),
			  workoutSetter(4, "Sedentary Exercise"),
              SizedBox(height: 20,),
              workoutSetter(0, "Light Exercise (1-2 Days a week)"),
              SizedBox(height: 20,),
              workoutSetter(1, "Good Exercise (3-5 Days a week)"),
              SizedBox(height: 20,),
              workoutSetter(2, "Hard Exercise (6-7 Days a week)"),
              SizedBox(height: 20,),
              workoutSetter(3, "Extreme Exercise (2x Training)"),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () async {
                  if (readyState) {
                    setState(() {
                      readyState = false;
                    });

                    await FirebaseFirestore.instance.collection('users')
                        .where('userID', isEqualTo: FirebaseManager.user!.uid!)
                        .get()
                        .then((querySnapshot) async {
                      if (querySnapshot.docs.isNotEmpty) {
                        // Assuming there's only one document per user
                        String documentID = querySnapshot.docs.first.id;

                        // Create a map with the fields to update
                        Map<String, dynamic> updateData = {};

                        updateData['goal'] = getGoal();
                        updateData['health_issue'] = getHealth();
                        updateData['workout'] = getFitness();

                        // Update the user document
                        await FirebaseFirestore.instance.collection('users').doc(documentID).update(updateData);

                        Fluttertoast.showToast(
                          msg: "User information updated!",
                        );

                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: "User not found.",
                        );
                      }
                    }).catchError((error) => {
                      Fluttertoast.showToast(
                        msg: "Error: $error",
                      ),
                    });
                  }
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                      color: Color(0xff454B60),
                      border: Border.all(color: Color(0xff454B60)),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: readyState? Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white),) : SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white,)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  goalSetter(int goalValue, String StrGoal) {
    return GestureDetector(
      onTap: () {
        setState(() {
          goal = goalValue;
        });
      },
      child: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Color(0xffE8EAF2),
          border: goalValue != goal ? Border.all(color: Color(0xffBFC2CD)) : Border.all(color: Colors.black),
        ),
        child: Center(child: Text(StrGoal, style: TextStyle(fontSize: 16, color: Colors.blueGrey),)),
      ),
    );
  }

  healthSetter(int goalValue, String StrGoal) {
    return GestureDetector(
      onTap: () {
        setState(() {
          health = goalValue;
        });
      },
      child: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Color(0xffE8EAF2),
          border: goalValue != health ? Border.all(color: Color(0xffBFC2CD)) : Border.all(color: Colors.black),
        ),
        child: Center(child: Text(StrGoal, style: TextStyle(fontSize: 16, color: Colors.blueGrey),)),
      ),
    );
  }

  workoutSetter(int goalValue, String StrGoal) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fitness = goalValue;
        });
      },
      child: Container(
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Color(0xffE8EAF2),
          border: goalValue != fitness ? Border.all(color: Color(0xffBFC2CD)) : Border.all(color: Colors.black),
        ),
        child: Center(child: Text(StrGoal, style: TextStyle(fontSize: 16, color: Colors.blueGrey),)),
      ),
    );
  }

  inputBox(String title, TextEditingController tempController, String hintText, bool rOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: rOnly ? Color(0xffE8EAF2) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Color(0xffBFC2CD),
                  width: 1
              )
          ),
          child: TextField(
            readOnly: rOnly,
            maxLines: 1,
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            controller: tempController,
            style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
            decoration: new InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: rOnly ? Colors.blueGrey[300] : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  secondInputBox(String title, String units, TextEditingController tempController) {
    return Row(
      children: [
        SizedBox(
            width: 100,
            child: Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),)
        ),
        SizedBox(width: 20,),
        Expanded(
          child: TextField(
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            controller: tempController,
            style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
            // decoration: new InputDecoration.collapsed(
            //   hintText: hintText,
            //   hintStyle: TextStyle(fontSize: 14, color: rOnly ? Colors.blueGrey[300] : Colors.grey),
            // ),
          ),
        ),
        SizedBox(
            width: 100,
            child: Text(units, style: TextStyle(fontSize: 16, color: Color(0xff454B60)), textAlign: TextAlign.right,)
        ),
      ],
    );
  }
}