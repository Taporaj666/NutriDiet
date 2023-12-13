import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseManager {
  static FirebaseAuth InstAuth = FirebaseAuth.instance;
  static PhoneAuthCredential? phoneCred;
  static UserCredential? userCred;
  static var verifID = null;
  static var user = FirebaseAuth.instance.currentUser;

  static Future<String?> createAccountWithEmailPassword(emailAddress, password) async {
    try {
      userCred = await InstAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<String?> assignNameToAccount (String name) async {
    try {
      await userCred?.user?.updateDisplayName(name);
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<String?> loginAccountWithEmailPassword (emailAddress, password) async {
    try {
      userCred = await InstAuth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      log("success");
      return "success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<void> logoutAccount () async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await InstAuth.signInWithCredential(credential);
  }

  static Future<bool> signInAnonymously() async {
    try {
      userCred = await InstAuth.signInAnonymously();
      final User? user = userCred?.user;
      if (user != null) {
        // Successful sign-in
        return true;
      }
    } catch (e) {
      print("Error signing in anonymously: $e");
      // Handle anonymous sign-in error
    }
    return false;
  }

  static Future<void> verifyPhoneNumberFirebase(String PNum) async {
    await InstAuth.verifyPhoneNumber(
      phoneNumber: "+92$PNum",
      verificationCompleted: (PhoneAuthCredential credential) {
        phoneCred = credential;
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        print("PAC Code Sent");
        verifID = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("PAC Code Timeout");
      },
    );
  }

  static Future<void> enterOTP(String OTPCode, context) async {
    print('checking OTP');
    phoneCred = PhoneAuthProvider.credential(
      verificationId: verifID,
      smsCode: OTPCode,
    );
  }
}