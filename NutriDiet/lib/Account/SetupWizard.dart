import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

import '../Home/Home.dart';

class SetupWizard extends StatefulWidget {
  const SetupWizard({super.key});

  @override
  State<SetupWizard> createState() => _SetupWizardState();
}

class _SetupWizardState extends State<SetupWizard> {

  TextEditingController genderController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();

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
              inputBox("Gender", genderController, "Male/Female", 1, false),
              SizedBox(height: 20,),
              inputBox("Height", heightController, "5'8", 5, true),
              SizedBox(height: 20,),
              inputBox("Weight", weightController, "85 Kg", 10, true),
              SizedBox(height: 20,),
              inputBox("Age", ageController, "21", 1, true),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: () async {
                  await nutriBase.addUser(genderController.text, heightController.text, weightController.text, ageController.text);
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

  inputBox(String title, TextEditingController tempController, String hintText, int maxLines, bool kbType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color(0xffE8EAF2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Color(0xffBFC2CD),
                  width: 1
              )
          ),
          child: TextField(
            keyboardType: kbType ? TextInputType.numberWithOptions() : TextInputType.text,
            maxLines: maxLines,
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            controller: tempController,
            style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
            decoration: new InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey[300]),
            ),
          ),
        ),
      ],
    );
  }
}