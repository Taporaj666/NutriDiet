import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutridiet/Account/Login.dart';
import 'package:nutridiet/BusinessLogic/Firebase.dart';
import 'package:nutridiet/Home/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser != null) {
    runApp(const MyApp(forwarder: HomeScreen()));
  } else {
    runApp(const MyApp(forwarder: LoginScreen()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.forwarder});
  final Widget forwarder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(Color(0xff454B60)),
        ),
      ),
      home: forwarder,
    );
  }
}