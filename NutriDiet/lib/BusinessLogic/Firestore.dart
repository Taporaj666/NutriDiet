import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Firebase.dart';

class nutriBase {

  static addRecipe(String name, String ingredients, String method, String image, String calories, String nutrients) async {
    if (name.isEmpty || ingredients.isEmpty || method.isEmpty || image.isEmpty || nutrients.isEmpty) {
      print("Null Fields");
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
            'nutrients': nutrients
          }
      ).then((value) async => {
        print("Recipe added"),
        Fluttertoast.showToast(
            msg: "Recipe added!",
        ),
      }).catchError((error) => {
        print("Error " + error),
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

  static addUser(String gender, String height, String weight, String age,String allergy, String goal, String healthIssue, String fitness) async {
    if (gender.isEmpty && height.isEmpty && weight.isEmpty && age.isEmpty && fitness.isEmpty) {
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
            'health_issue': healthIssue,
            'allergy': allergy,
            'workout': fitness
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

  static updateUser(String userID, String newWeight, String newHeight, String newAge, String newAllergy) async {
    if (userID.isEmpty || (newWeight.isEmpty && newHeight.isEmpty && newAge.isEmpty)) {
      Fluttertoast.showToast(
        msg: "Please provide valid user ID and at least one field to update.",
      );
    } else {
      await FirebaseFirestore.instance.collection('users')
          .where('userID', isEqualTo: userID)
          .get()
          .then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          // Assuming there's only one document per user
          String documentID = querySnapshot.docs.first.id;

          // Create a map with the fields to update
          Map<String, dynamic> updateData = {};

          if (newWeight.isNotEmpty) {
            updateData['weight'] = newWeight;
          }

          if (newHeight.isNotEmpty) {
            updateData['height'] = newHeight;
          }

          if (newAge.isNotEmpty) {
            updateData['age'] = newAge;
          }

          if (newAllergy.isNotEmpty) {
            updateData['allergy'] = newAllergy;
          }

          // Update the user document
          await FirebaseFirestore.instance.collection('users').doc(documentID).update(updateData);

          Fluttertoast.showToast(
            msg: "User information updated!",
          );
        } else {
          Fluttertoast.showToast(
            msg: "User not found.",
          );
        }
      }).catchError((error) => {
        Fluttertoast.showToast(
          msg: "Error: $error",
        ),
      });
    }
    return;
  }

  static addDay(
      DateTime daySelected,
      // Breakfast
      double bCalories,
      double bProtein,
      double bSugar,
      double bFats,
      double bFiber,
      double bCalcium,
      double bCarbs,
      double bIron,
      double bSaturatedFats,
      double bUnsaturatedFats,
      double bMagnesium,
      double bTransFats,
      double bPotassium,
      double bManganese,
      double bSelenium,
      double bSodium,
      double bZinc,
      double bIodine,
      double bVitaminA,
      double bVitaminB1,
      double bVitaminB2,
      double bVitaminB5,
      double bVitaminB6,
      double bVitaminB7,
      double bVitaminB9,
      double bVitaminB12,
      double bVitaminC,
      double bVitaminD,
      double bVitaminE,
      double bVitaminF,
      double bVitaminK,
      double bVitaminB3,
      double bChloride,
      double bCopper,
      double bChromium,
      double bPhosphorus,
      double bFluoride,
      // Lunch
      double lCalories,
      double lProtein,
      double lSugar,
      double lFats,
      double lFiber,
      double lCalcium,
      double lCarbs,
      double lIron,
      double lSaturatedFats,
      double lUnsaturatedFats,
      double lMagnesium,
      double lTransFats,
      double lPotassium,
      double lManganese,
      double lSelenium,
      double lSodium,
      double lZinc,
      double lIodine,
      double lVitaminA,
      double lVitaminB1,
      double lVitaminB2,
      double lVitaminB5,
      double lVitaminB6,
      double lVitaminB7,
      double lVitaminB9,
      double lVitaminB12,
      double lVitaminC,
      double lVitaminD,
      double lVitaminE,
      double lVitaminF,
      double lVitaminK,
      double lVitaminB3,
      double lChloride,
      double lCopper,
      double lChromium,
      double lPhosphorus,
      double lFluoride,
      // Dinner
      double dCalories,
      double dProtein,
      double dSugar,
      double dFats,
      double dFiber,
      double dCalcium,
      double dCarbs,
      double dIron,
      double dSaturatedFats,
      double dUnsaturatedFats,
      double dMagnesium,
      double dTransFats,
      double dPotassium,
      double dManganese,
      double dSelenium,
      double dSodium,
      double dZinc,
      double dIodine,
      double dVitaminA,
      double dVitaminB1,
      double dVitaminB2,
      double dVitaminB5,
      double dVitaminB6,
      double dVitaminB7,
      double dVitaminB9,
      double dVitaminB12,
      double dVitaminC,
      double dVitaminD,
      double dVitaminE,
      double dVitaminF,
      double dVitaminK,
      double dVitaminB3,
      double dChloride,
      double dCopper,
      double dChromium,
      double dPhosphorus,
      double dFluoride,
      ) async {
    print("Started adding");

    await FirebaseFirestore.instance.collection('intake')
        .where('userID', isEqualTo: FirebaseManager.user!.uid!)
        .where('date', isEqualTo: daySelected)
        .get()
        .then((querySnapshot) async {
      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('intake').add(
          {
            'userID': FirebaseManager.user!.uid!,
            'date': daySelected,
            // Breakfast
            'breakfast_calories': bCalories,
            'breakfast_protein': bProtein,
            'breakfast_sugar': bSugar,
            'breakfast_fats': bFats,
            'breakfast_fiber': bFiber,
            'breakfast_calcium': bCalcium,
            'breakfast_carbs': bCarbs,
            'breakfast_iron': bIron,
            'breakfast_saturated_fats': bSaturatedFats,
            'breakfast_unsaturated_fats': bUnsaturatedFats,
            'breakfast_magnesium': bMagnesium,
            'breakfast_trans_fats': bTransFats,
            'breakfast_potassium': bPotassium,
            'breakfast_manganese': bManganese,
            'breakfast_selenium': bSelenium,
            'breakfast_sodium': bSodium,
            'breakfast_zinc': bZinc,
            'breakfast_iodine': bIodine,
            'breakfast_vitamin_a': bVitaminA,
            'breakfast_vitamin_b1': bVitaminB1,
            'breakfast_vitamin_b2': bVitaminB2,
            'breakfast_vitamin_b5': bVitaminB5,
            'breakfast_vitamin_b6': bVitaminB6,
            'breakfast_vitamin_b7': bVitaminB7,
            'breakfast_vitamin_b9': bVitaminB9,
            'breakfast_vitamin_b12': bVitaminB12,
            'breakfast_vitamin_c': bVitaminC,
            'breakfast_vitamin_d': bVitaminD,
            'breakfast_vitamin_e': bVitaminE,
            'breakfast_vitamin_f': bVitaminF,
            'breakfast_vitamin_k': bVitaminK,
            'breakfast_vitamin_b3': bVitaminB3,
            'breakfast_chloride': bChloride,
            'breakfast_copper': bCopper,
            'breakfast_chromium': bChromium,
            'breakfast_phosphorus': bPhosphorus,
            'breakfast_fluoride': bFluoride,
            // Lunch
            'lunch_calories': lCalories,
            'lunch_protein': lProtein,
            'lunch_sugar': lSugar,
            'lunch_fats': lFats,
            'lunch_fiber': lFiber,
            'lunch_calcium': lCalcium,
            'lunch_carbs': lCarbs,
            'lunch_iron': lIron,
            'lunch_saturated_fats': lSaturatedFats,
            'lunch_unsaturated_fats': lUnsaturatedFats,
            'lunch_magnesium': lMagnesium,
            'lunch_trans_fats': lTransFats,
            'lunch_potassium': lPotassium,
            'lunch_manganese': lManganese,
            'lunch_selenium': lSelenium,
            'lunch_sodium': lSodium,
            'lunch_zinc': lZinc,
            'lunch_iodine': lIodine,
            'lunch_vitamin_a': lVitaminA,
            'lunch_vitamin_b1': lVitaminB1,
            'lunch_vitamin_b2': lVitaminB2,
            'lunch_vitamin_b5': lVitaminB5,
            'lunch_vitamin_b6': lVitaminB6,
            'lunch_vitamin_b7': lVitaminB7,
            'lunch_vitamin_b9': lVitaminB9,
            'lunch_vitamin_b12': lVitaminB12,
            'lunch_vitamin_c': lVitaminC,
            'lunch_vitamin_d': lVitaminD,
            'lunch_vitamin_e': lVitaminE,
            'lunch_vitamin_f': lVitaminF,
            'lunch_vitamin_k': lVitaminK,
            'lunch_vitamin_b3': lVitaminB3,
            'lunch_chloride': lChloride,
            'lunch_copper': lCopper,
            'lunch_chromium': lChromium,
            'lunch_phosphorus': lPhosphorus,
            'lunch_fluoride': lFluoride,
            // Dinner
            'dinner_calories': dCalories,
            'dinner_protein': dProtein,
            'dinner_sugar': dSugar,
            'dinner_fats': dFats,
            'dinner_fiber': dFiber,
            'dinner_calcium': dCalcium,
            'dinner_carbs': dCarbs,
            'dinner_iron': dIron,
            'dinner_saturated_fats': dSaturatedFats,
            'dinner_unsaturated_fats': dUnsaturatedFats,
            'dinner_magnesium': dMagnesium,
            'dinner_trans_fats': dTransFats,
            'dinner_potassium': dPotassium,
            'dinner_manganese': dManganese,
            'dinner_selenium': dSelenium,
            'dinner_sodium': dSodium,
            'dinner_zinc': dZinc,
            'dinner_iodine': dIodine,
            'dinner_vitamin_a': dVitaminA,
            'dinner_vitamin_b1': dVitaminB1,
            'dinner_vitamin_b2': dVitaminB2,
            'dinner_vitamin_b5': dVitaminB5,
            'dinner_vitamin_b6': dVitaminB6,
            'dinner_vitamin_b7': dVitaminB7,
            'dinner_vitamin_b9': dVitaminB9,
            'dinner_vitamin_b12': dVitaminB12,
            'dinner_vitamin_c': dVitaminC,
            'dinner_vitamin_d': dVitaminD,
            'dinner_vitamin_e': dVitaminE,
            'dinner_vitamin_f': dVitaminF,
            'dinner_vitamin_k': dVitaminK,
            'dinner_vitamin_b3': dVitaminB3,
            'dinner_chloride': dChloride,
            'dinner_copper': dCopper,
            'dinner_chromium': dChromium,
            'dinner_phosphorus': dPhosphorus,
            'dinner_fluoride': dFluoride,
          },
        ).then((value) async => {
          Fluttertoast.showToast(
            msg: "Meals added!",
          ),
        }).catchError((error) => {
          Fluttertoast.showToast(
            msg: "Error: $error",
          ),
        });
      } else {
        // Entry already exists for the specified date
        Fluttertoast.showToast(
          msg: "Meals for this day already exist.",
        );
      }
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
        rawData.docs[i].data()["image"],
        rawData.docs[i].data()["nutrients"],]
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