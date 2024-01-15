import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutridiet/Account/Login.dart';
import 'package:nutridiet/BusinessLogic/Firebase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool working = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Spacer(),
                Text("You are logged in as ${FirebaseManager.user?.displayName}!"),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      working = true;
                    });
                    await FirebaseManager.logoutAccount();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Color(0xff454B60),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: !working? Text("Logout", style: TextStyle(fontSize: 14, color: Colors.white),) : SizedBox(height: 18, width: 18, child: CircularProgressIndicator(color: Colors.white,)),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          )
        ),
      ),
    );
  }
}
