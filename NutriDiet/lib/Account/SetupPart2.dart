import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

import '../BusinessLogic/Firebase.dart';
import '../Home/Home.dart';
import 'Login.dart';

class SetupWizard2 extends StatefulWidget {
  const SetupWizard2({super.key, required this.age, required this.height, required this.weight, required this.gender});

  final String age;
  final String height;
  final String weight;
  final String gender;

  @override
  State<SetupWizard2> createState() => _SetupWizard2State();
}

class _SetupWizard2State extends State<SetupWizard2> {

  int goal = 0;
  int health = 4;
  int fitness = 0;
  TextEditingController allergyController = new TextEditingController();

  bool readyState = true;

  @override void initState() {
    // TODO: implement initState
    super.initState();
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
              SizedBox(height: 40,),
              inputBox("Allergy", allergyController, "E.g Soy", false),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () async {
                  if (readyState) {
                    setState(() {
                      readyState = false;
                    });
                    await nutriBase.addUser(widget.gender, widget.height, widget.weight, widget.age, allergyController.text, getGoal(), getHealth(), getFitness());
                    await FirebaseManager.logoutAccount();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
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