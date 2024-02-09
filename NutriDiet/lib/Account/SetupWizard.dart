import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutridiet/Account/SetupPart2.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

import '../BusinessLogic/Firebase.dart';
import '../Home/Home.dart';

class SetupWizard extends StatefulWidget {
  const SetupWizard({super.key});

  @override
  State<SetupWizard> createState() => _SetupWizardState();
}

class _SetupWizardState extends State<SetupWizard> {

  bool genderController = true;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();

  @override void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = FirebaseManager.user!.displayName!;
    emailController.text = FirebaseManager.user!.email!;
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
              textRow("Name: ", nameController.text, 16, ''),
              // inputBox("Name", nameController, "E.g Dave", true),
              SizedBox(height: 20,),
              textRow("Email: ", emailController.text, 16, ''),
              // inputBox("Email", emailController, "E.g. Dave@website.com", true),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Gender", style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        genderController = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: genderController ? Color(0xff454B60) : Colors.white,
                          border: Border.all(color: Color(0xff454B60)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text("Male", style: TextStyle(fontSize: 16, color: genderController ? Colors.white : Color(0xff454B60)),)),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        genderController = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: !genderController ? Color(0xff454B60) : Colors.white,
                          border: Border.all(color: Color(0xff454B60)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text("Female", style: TextStyle(fontSize: 16, color: !genderController ? Colors.white : Color(0xff454B60)),)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              secondInputBox("Height", "Centimeters", heightController),
              SizedBox(height: 20,),
              secondInputBox("Weight", "Kgs", weightController),
              SizedBox(height: 20,),
              secondInputBox("Age", "Years", ageController),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () async {
                  // await nutriBase.addUser(genderController? "Male" : "Female", heightController.text, weightController.text, ageController.text);
                  if (!ageController.text.isEmpty) {
                    if (!heightController.text.isEmpty) {
                      if (!weightController.text.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SetupWizard2(age: ageController.text, height: heightController.text, weight: weightController.text, gender: genderController? "Male" : "Female",)),
                        );
                      }
                      else {
                        Fluttertoast.showToast(
                          msg: "Please fill all fields",
                        );
                      }
                    }
                    else {
                      Fluttertoast.showToast(
                        msg: "Please fill all fields",
                      );
                    }
                  }
                  else {
                    Fluttertoast.showToast(
                      msg: "Please fill all fields",
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                      color: Color(0xff454B60),
                      border: Border.all(color: Color(0xff454B60)),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text("Next", style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  textRow(String title, String value, double size, String units) {
    return Row(
      children: [
        Text(title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff3D4048),
              fontSize: size,
              fontWeight: FontWeight.w400
          ),
        ),
        Spacer(),
        Text(value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff3D4048),
              fontSize: size,
              fontWeight: FontWeight.w800
          ),
        ),
        Text(" $units",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff3D4048),
              fontSize: size,
              fontWeight: FontWeight.w400
          ),
        ),
      ],
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