import 'package:flutter/Material.dart';

import 'Admin/Home.dart';
import 'BusinessLogic/Firebase.dart';
import 'Home/Home.dart';

class checker extends StatefulWidget {
  const checker({super.key});

  @override
  State<checker> createState() => _checkerState();
}

class _checkerState extends State<checker> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPage();
  }

  loadPage() async {
    await Future.delayed(Duration(seconds: 1));
    if (FirebaseManager.user!.email! == "admin@nutridiet.com") {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => AdminHomeScreen()), (route) => false);
    }
    else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      child: Center(
        child: CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
