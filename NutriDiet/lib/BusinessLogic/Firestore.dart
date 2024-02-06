import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Firebase.dart';

class nutriBase {

  static addRecipe(String name, String ingredients, String method, String image, String calories) async {
    if (name.isEmpty || ingredients.isEmpty || method.isEmpty || image.isEmpty) {
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

  static Future<bool> deleteRecipe(String recipeId) async {
    try {
      await FirebaseFirestore.instance.collection('recipes').doc(recipeId).delete();
      Fluttertoast.showToast(
        msg: "Recipe deleted!",
      );
      return true;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error: $error",
      );
      return false;
    }
  }

  static Future<bool> deleteSellable(String recipeId) async {
    try {
      await FirebaseFirestore.instance.collection('forsale').doc(recipeId).delete();
      Fluttertoast.showToast(
        msg: "Recipe deleted!",
      );
      return true;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error: $error",
      );
      return false;
    }
  }

  static addbuyableRecipe(String name, String seller, String sellerEmail, String image, int calories, int price) async {
    if (name.isEmpty || image.isEmpty || calories == 0 || price == 0) {
      Fluttertoast.showToast(
        msg: "Please fill all fields",
      );
    }
    else {
      await FirebaseFirestore.instance.collection('forsale').add(
          {
            'caterer': seller,
            'catererEmail': sellerEmail,
            'name': name,
            'calories': calories,
            'image': image,
            'price': price,
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

  static addUser(String gender, String height, String weight, String age,String allergy, String goal) async {
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
            'goal': goal,
            'allergy': allergy
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

  static addDay(DateTime daySelected, int bCalories, int bProtien, int bSugar, int bFats, int bFiber, int lCalories, int lProtien, int lSugar, int lFats, int lFiber, int dCalories, int dProtien, int dSugar, int dFats, int dFiber) async {
    await FirebaseFirestore.instance.collection('intake').add(
        {
          'userID': FirebaseManager.user!.uid!,
          'date': daySelected,
          'breakfast_calories': bCalories,
          'breakfast_protein': bProtien,
          'breakfast_fats': bFats,
          'breakfast_sugar': bSugar,
          'breakfast_fiber': bFiber,
          'lunch_calories': lCalories,
          'lunch_protein': lProtien,
          'lunch_fats': lFats,
          'lunch_sugar': lSugar,
          'lunch_fiber': lFiber,
          'dinner_calories': dCalories,
          'dinner_protein': dProtien,
          'dinner_fats': dFats,
          'dinner_sugar': dSugar,
          'dinner_fiber': dFiber,
        }
    ).then((value) async => {
      Fluttertoast.showToast(
        msg: "meals added!",
      ),
    }).catchError((error) => {
      Fluttertoast.showToast(
        msg: "Error: $error",
      ),
    });
    return;
  }

  static calculateBMR(bool male, double weight, double height, double age) {
    double artificialGenderConstant = male ? 88.362 : 447.593;
    double artificialWeightConstant = male ? 13.397 : 9.247;
    double artificialHeightConstant = male ? 4.799 : 3.098;
    double artificialAgeConstant = male ? 5.677 : 4.330;

    double BMR = artificialGenderConstant + (weight * artificialWeightConstant) + (height * artificialHeightConstant) - (age * artificialAgeConstant);

    return BMR;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMealDataOfDay(DateTime selectedDate) async {
    DateTime startDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 0);
    DateTime endDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

    var rawData = await FirebaseFirestore.instance.collection('intake')
        .where('userID', isEqualTo: FirebaseManager.user!.uid!)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .orderBy('date')
        .get();

    return rawData.docs;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMealDataOfMonth(DateTime selectedMonth) async {
    DateTime firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1, 0, 0, 0);
    DateTime lastDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0, 23, 59, 59);

    var rawData = await FirebaseFirestore.instance.collection('intake')
        .where('userID', isEqualTo: FirebaseManager.user!.uid!)
        .where('date', isGreaterThanOrEqualTo: firstDayOfMonth)
        .where('date', isLessThanOrEqualTo: lastDayOfMonth)
        .orderBy('date')
        .get();

    return rawData.docs;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMealDataOfAll() async {
    var rawData = await FirebaseFirestore.instance.collection('intake').where('userID', isEqualTo: FirebaseManager.user!.uid!).orderBy('date').limit(365).get();
    return rawData.docs;
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getUserData() async {
    var rawData = await FirebaseFirestore.instance.collection('users').where('userID', isEqualTo: FirebaseManager.user!.uid!).get();
    return rawData.docs;
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

  static Future<List<List<dynamic>>> getBuyableRecipes() async {
    List<List<dynamic>> activeOrders = [];

    // var rawData = await FirebaseFirestore.instance.collection('recipes').where('active', isEqualTo: true).orderBy("time", descending: false).get();

    var rawData = await FirebaseFirestore.instance.collection('forsale').get();

    for (int i = 0; i < rawData.docs.length; i++) {
      activeOrders.add([
        rawData.docs[i].id,
        rawData.docs[i].data()["name"].toString(),
        rawData.docs[i].data()["calories"],
        rawData.docs[i].data()["price"],
        rawData.docs[i].data()["image"],
        rawData.docs[i].data()["catererEmail"].toString(),
        rawData.docs[i].data()["caterer"].toString(),
      ]);
    }

    return activeOrders;
  }
}