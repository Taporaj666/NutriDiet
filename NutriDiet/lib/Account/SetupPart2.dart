import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

import '../BusinessLogic/Firebase.dart';
import '../Home/Home.dart';

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
  TextEditingController allergyController = new TextEditingController();

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
              inputBox("Allergy", allergyController, "E.g Soy", false),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () async {
                  await nutriBase.addUser(widget.gender, widget.height, widget.weight, widget.age, allergyController.text, getGoal());
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                      color: Color(0xff454B60),
                      border: Border.all(color: Color(0xff454B60)),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white),)),
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