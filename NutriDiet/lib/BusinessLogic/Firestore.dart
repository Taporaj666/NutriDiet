import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Firebase.dart';

class nutriBase {

  static addRecipe(String name, String ingredients, String method, String image, String calories) async {
    if (name.isEmpty && ingredients.isEmpty && method.isEmpty && image.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill all fields",
      );
    }
    else {
      await FirebaseFirestore.instance.collection('recipes').add(
          {
            'name': name,
            'ingredients': ingredients,
            'method': method,
            'image': image,
            'calories': calories,
          }
      ).then((value) async => {
        Fluttertoast.showToast(
            msg: "Recipe added!",
        ),
      }).catchError((error) => {
        Fluttertoast.showToast(
            msg: "Error: $error",
        ),
      });
    }
    return;
  }

  static addUser(String gender, String height, String weight, String age) async {
    if (gender.isEmpty && height.isEmpty && weight.isEmpty && age.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all fields",
      );
    }
    else {
      await FirebaseFirestore.instance.collection('users').add(
          {
            'userID': FirebaseManager.user!.uid!,
            'gender': gender,
            'weight': weight,
            'height': height,
            'age': age,
          }
      ).then((value) async => {
        Fluttertoast.showToast(
          msg: "User added!",
        ),
      }).catchError((error) => {
        Fluttertoast.showToast(
          msg: "Error: $error",
        ),
      });
    }
    return;
  }

  static getUserData() async {
    List<String> userData = [];

    var rawData = await FirebaseFirestore.instance.collection('users').where('userID', isEqualTo: FirebaseManager.user!.uid!).get();

    userData.add(rawData.docs[0].data()["gender"].toString(),);
    userData.add(rawData.docs[0].data()["weight"].toString(),);
    userData.add(rawData.docs[0].data()["height"].toString(),);
    userData.add(rawData.docs[0].data()["age"].toString(),);

    return userData;
  }

  static Future<List<List<dynamic>>> getRecipes() async {
    List<List<dynamic>> activeOrders = [];

    // var rawData = await FirebaseFirestore.instance.collection('recipes').where('active', isEqualTo: true).orderBy("time", descending: false).get();

    var rawData = await FirebaseFirestore.instance.collection('recipes').get();

    for (int i = 0; i < rawData.docs.length; i++) {
      activeOrders.add([
        rawData.docs[i].id,
        rawData.docs[i].data()["name"].toString(),
        rawData.docs[i].data()["calories"],
        rawData.docs[i].data()["ingredients"],
        rawData.docs[i].data()["method"],
        rawData.docs[i].data()["image"],]
      );
    }

    return activeOrders;
  }
}