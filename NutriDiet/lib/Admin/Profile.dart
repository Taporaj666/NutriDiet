import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:nutridiet/Home/SubPages/TermsConditions.dart';

import '../../Account/Login.dart';
import '../../Account/SetupWizard.dart';
import '../../BusinessLogic/Firebase.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _ProfileState();
}

class _ProfileState extends State<AdminProfile> {

  TextEditingController genderController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderController.text = "Loading...";
    ageController.text = "Loading...";
    heightController.text = "Loading...";
    weightController.text = "Loading...";
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
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text("User Details", style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
            //     SizedBox(height: 20,),
            //     editField("Gender", genderController, false),
            //     SizedBox(height: 10,),
            //     editField("Age", ageController, true),
            //     SizedBox(height: 10,),
            //     editField("Height", heightController, true),
            //     SizedBox(height: 10,),
            //     editField("Weight", weightController, true),
            //   ],
            // ),
            // SizedBox(height: 40,),
            // Row(
            //   children: [
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: () async {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => TermsConditions()),
            //           );
            //         },
            //         child: Container(
            //             padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            //             decoration: BoxDecoration(
            //               // color: Colors.white,
            //                 border: Border.all(color: Color(0xff454B60)),
            //                 borderRadius: BorderRadius.circular(5)
            //             ),
            //             child: Row(
            //               children: [
            //                 Text("Terms and Conditions", style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
            //                 Spacer(),
            //                 Icon(Icons.open_in_new, color: Colors.blueGrey),
            //               ],
            //             )
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 40,),
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
        ),
      ),
    );
  }

  editField(String title, TextEditingController fieldController, bool isNumeric) {
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
              readOnly: true,
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
