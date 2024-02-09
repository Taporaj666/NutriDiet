import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:nutridiet/Account/UpdateSecondary.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:nutridiet/Home/SubPages/TermsConditions.dart';

import '../../Account/Login.dart';
import '../../Account/SetupWizard.dart';
import '../../BusinessLogic/Firebase.dart';
import 'SubHome.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController genderController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController allergyController = new TextEditingController();
  TextEditingController workoutController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderController.text = "Loading...";
    ageController.text = "Loading...";
    heightController.text = "Loading...";
    weightController.text = "Loading...";
    allergyController.text = "Loading...";
    loadData();
  }

  loadData() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userData = await nutriBase.getUserData();
    print(userData.toString());
    if (userData.length == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SetupWizard()),
      );
    }
    genderController.text = userData[0].data()["gender"].toString();
    ageController.text = userData[0].data()["age"].toString();
    heightController.text = userData[0].data()["height"].toString();
    weightController.text = userData[0].data()["weight"].toString();
    allergyController.text = userData[0].data()["allergy"].toString();
    setState(() {
      workoutController.text = userData[0].data()["workout"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   child: Icon(Icons.arrow_back, color: Color(0xff454B60)),
                // ),
                Spacer(),
                Text("Profile", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
                Spacer(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Spacer(),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffE8EAF2),
                          border: Border.all(color: Color(0xff454B60)),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                        child: Icon(Icons.person_outline, size: 58,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(FirebaseManager.user!.displayName!, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 40,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User Details", style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.pink[200]!],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Your BMR: ",
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      Text(
                        actualUserBMR,
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(height: 20,),
                editField("Gender", genderController, false, true),
                SizedBox(height: 10,),
                editField("Age", ageController, true, false),
                SizedBox(height: 10,),
                editField("Height", heightController, true, false),
                SizedBox(height: 10,),
                editField("Weight", weightController, true, false),
                SizedBox(height: 10,),
                editField("Allergy", allergyController, false, false),
                // SizedBox(height: 10,),
                // editField("Workout", workoutController, false, true),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                // Spacer(),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpdateSecondary()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      decoration: BoxDecoration(
                          color: Color(0xff454B60),
                          border: Border.all(color: Color(0xff454B60)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text("Edit Others", style: TextStyle(fontSize: 16, color: Colors.white),)),
                    ),
                  ),
                ),
                // Spacer(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                // Spacer(),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      nutriBase.updateUser(FirebaseManager.user!.uid!, weightController.text, heightController.text, ageController.text, allergyController.text);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      decoration: BoxDecoration(
                          color: Color(0xff454B60),
                          border: Border.all(color: Color(0xff454B60)),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text("Update", style: TextStyle(fontSize: 16, color: Colors.white),)),
                    ),
                  ),
                ),
                SizedBox(width: 40,),
                Expanded(
                  child: GestureDetector(
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
                      child: Center(child: Text("Logout", style: TextStyle(fontSize: 16, color: Colors.white),)),
                    ),
                  ),
                ),
                // Spacer(),
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsConditions()),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          children: [
                            Text("Terms and Conditions", style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
                            Spacer(),
                            Icon(Icons.open_in_new, color: Colors.blueGrey),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  editField(String title, TextEditingController fieldController, bool isNumeric, bool readOnly) {
    return Row(
      children: [
        SizedBox(
          width: 100,
            child: Text("$title:", style: TextStyle(fontSize: 16, color: Color(0xff454B60)),)
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xff454B60)),
                borderRadius: BorderRadius.circular(15)
            ),
            child: TextField(
              readOnly: readOnly,
              keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
              obscureText: false,
              enableSuggestions: true,
              autocorrect: true,
              controller: fieldController,
              style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              decoration: new InputDecoration.collapsed(
                hintText: "Enter Data",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
