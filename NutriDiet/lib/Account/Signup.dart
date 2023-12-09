import 'package:flutter/material.dart';
import 'package:nutridiet/BusinessLogic/Firebase.dart';

import '../Home/Home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool nameErrorController = false;
  bool emailErrorController = false;
  bool passErrorController = false;
  bool cpassErrorController = false;
  bool checkboxErrorController = false;

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController cpassword = new TextEditingController();

  String nameError = "";
  String emailError = "";
  String passError = "";
  String cpassError = "";

  bool isChecked = true;
  bool error = false;
  bool working = false;

  String message = "Enter your details to register";

  checkAllFieldsFull() {
    bool trigger = false;
    if (name.text == "") {
      nameErrorController = true;
      nameError = "Field is Empty";
      trigger = true;
    }
    else {
      nameErrorController = false;
    }
    if (email.text == "") {
      emailErrorController = true;
      emailError = "Field is Empty";
      trigger = true;
    }
    else {
      emailErrorController = false;
    }
    if (password.text == "") {
      passErrorController = true;
      passError = "Field is Empty";
      trigger = true;
    }
    else {
      passErrorController = false;
    }
    if (cpassword.text == "") {
      cpassErrorController = true;
      cpassError = "Field is Empty";
      trigger = true;
    }
    else {
      cpassErrorController = false;
    }
    if (isChecked = false) {
      checkboxErrorController = true;
      trigger = true;
    }
    else {
      checkboxErrorController = false;
    }
    setState(() {});
    if (!trigger) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.image_outlined, size: 72,),
              SizedBox(height: 20,),
              Text("Register", style: TextStyle(fontSize: 24, color: Color(0xff454B60), fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(message,
                textAlign: TextAlign.center,
                style: error ? TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ) : TextStyle(
                    color: Color(0xff454B60),
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30,),
              CustomTextBox(name, "Name", nameErrorController, nameError),
              SizedBox(height: 10,),
              CustomTextBox(email, "Email", emailErrorController, emailError),
              SizedBox(height: 10,),
              CustomTextBox(password, "Password", passErrorController, passError),
              SizedBox(height: 10,),
              CustomTextBox(cpassword, "Confirm Password", cpassErrorController, cpassError),
              SizedBox(height: 10,),
              Row(
                children: [
                  Checkbox(
                    isError: true,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  SizedBox(width: 10,),
                  Text("I agree with the terms and conditions", style: !checkboxErrorController ? TextStyle(fontSize: 14, color: Color(0xff454B60), fontWeight: FontWeight.bold) : TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: () async {
                  if (checkAllFieldsFull()) {
                    if (password.text.length < 6) {
                      passErrorController = true;
                      passError = "Password must be 6 characters";
                    }
                    else if (password.text != cpassword.text) {
                      cpassErrorController = true;
                      cpassError = "Passwords do not match";
                    }
                    else {
                      setState(() {
                        working = true;
                      });
                      String? responseMessage = await FirebaseManager.createAccountWithEmailPassword(email.text, password.text);
                      String? otherMessage = await FirebaseManager.assignNameToAccount(name.text);

                      print(responseMessage);
                      print(otherMessage);

                      if (responseMessage! == "success") {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
                      }
                      else {
                        setState(() {
                          message = "Error: $responseMessage";
                          working = false;
                          error = true;
                        });
                      }
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Color(0xff454B60),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: !working? Text("Next", style: TextStyle(fontSize: 14, color: Colors.white),) : SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white,)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomTextBox(TextEditingController recontroller, String hintText, bool errorController, String errorMessage) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xff454B60),
              )
          ),
          child: Center(
            child: TextField(
              controller: recontroller,
              style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              decoration: new InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              ),
            ),
          ),
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            Visibility(
                visible: errorController,
                child: Text(errorMessage, style: TextStyle(fontSize: 14, color: Colors.red),)
            ),
            Spacer(),
            Text(" ", style: TextStyle(fontSize: 14, color: Color(0xff454B60)),),
          ],
        )
      ],
    );
  }
}
