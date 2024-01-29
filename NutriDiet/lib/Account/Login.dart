import 'package:flutter/material.dart';
import 'package:nutridiet/Account/Signup.dart';
import 'package:nutridiet/BusinessLogic/Firebase.dart';
import 'package:nutridiet/Home/Home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController message = new TextEditingController();

  bool error = false;
  bool working = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message.text = "Enter your username and password to login";
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
              Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: AssetImage('assets/logo.jpg'), fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: 50,),
              Text("Login", style: TextStyle(fontSize: 24, color: Color(0xff454B60), fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(message.text,
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
              CustomTextBox(username, "Email", false),
              SizedBox(height: 10,),
              CustomTextBox(password, "Password", true),
              SizedBox(height: 10,),
              InkWell(
                onTap: () async {
                  if (!working) {
                    if (username.text.isEmpty || password.text.isEmpty) {
                      setState(() {
                        working = false;
                        error = true;
                        message.text = "Please fill all fields";
                      });
                    }
                    else if (password.text.length < 6) {
                      setState(() {
                        working = false;
                        error = true;
                        message.text = "Password length is too small";
                      });
                    }
                    else if (username.text != "" && password.text != "") {
                      setState(() {
                        working = true;
                      });
                      String? returnMessage = await FirebaseManager.loginAccountWithEmailPassword(username.text, password.text);
                      print(returnMessage!);
                      if (returnMessage! == "success") {
                        setState(() {
                          error = false;
                          message.text = "Login Success";
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
                        });
                      }
                      else {
                        setState(() {
                          working = false;
                          error = true;
                          message.text = "Invalid Email/Password";
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
                    child: !working? Text("Login", style: TextStyle(fontSize: 14, color: Colors.white),) : SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white,)),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Spacer(),
                        Text("Don't have an account? ", style: TextStyle(fontSize: 14, color: Color(0xff454B60)),),
                        Text("Register", style: TextStyle(fontSize: 14, color: Color(0xff454B60), fontWeight: FontWeight.bold),),
                        Spacer(),
                      ],
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomTextBox(TextEditingController recontroller, String hintText, bool isPassword) {
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
              obscureText: isPassword,
              enableSuggestions: !isPassword,
              autocorrect: !isPassword,
              controller: recontroller,
              style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              decoration: new InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              ),
            ),
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}
