import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../BusinessLogic/Firebase.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController email = new TextEditingController();
  TextEditingController feedback = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = FirebaseManager.user!.email!;
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
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)
                    ),
                    Text(
                      " User Feedback",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                inputBox("Email", email, "Loading...", 1, true),
                SizedBox(height: 30,),
                inputBox("Feedback", feedback, "Write Something to Forward", 10, false),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Fluttertoast.showToast(
                          msg: "Feedback Sent",
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            color: Color(0xff454B60),
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Send", style: TextStyle(fontSize: 16, color: Colors.white),),
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
            readOnly: kbType,
            keyboardType: TextInputType.text,
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