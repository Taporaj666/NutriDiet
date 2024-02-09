import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:nutridiet/BusinessLogic/ImageHelper.dart';
import 'package:nutridiet/BusinessLogic/utils.dart';
import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image/image.dart' as IMG;
import 'package:nutridiet/Home/SubPages/SubHome.dart';

import '../../Account/SetupWizard.dart';
import 'Recipe.dart';

class FoodPlanner extends StatefulWidget {
  const FoodPlanner({super.key});

  @override
  State<FoodPlanner> createState() => _searchPageState();
}

class _searchPageState extends State<FoodPlanner> {
  final imageHelper = ImageHelper();
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  File? _image;

  bool loadedRecommendedRecipes = false;
  List<List<dynamic>> breakfast = [["", "Enter Goal", "", "", "", "", ""]];
  List<List<dynamic>> lunchfast = [["", "Enter Goal", "", "", "", "", ""]];
  List<List<dynamic>> dinnerfast = [["", "Enter Goal", "", "", "", "", ""]];

  String title = "---";
  String calories = "---";
  String description = "---";
  String goal = "---";
  String health = "---";
  String allergy = "---";
  late String workout = "";

  TextEditingController breakfastFoodController = new TextEditingController();
  TextEditingController lunchFoodController = new TextEditingController();
  TextEditingController dinnerFoodController = new TextEditingController();

  @override
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

    breakfastFoodController.text = "150";
    lunchFoodController.text = "250";
    dinnerFoodController.text = "300";

  }

  loadData() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userData = await nutriBase.getUserData();
    print(userData.toString());
    if (userData.length == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SetupWizard()),
      );
    }
    goal = userData[0].data()["goal"].toString();
    health = userData[0].data()["health_issue"].toString();
    allergy = userData[0].data()["allergy"].toString();
    workout = userData[0].data()["workout"].toString();

    print("Alergy: " + allergy);

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Text(
                        " Food Planning",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  textRow("Daily Calorie Goals", "", 24),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  textRow("Allergies:", allergy, 16),
                  SizedBox(height: 10,),
                  textRow("Workout:", workout, 16),
                  SizedBox(height: 10,),
                  Divider(),
                  // SizedBox(height: 10,),
                  // textRow("Medium Exercise:", biasGenerator(1.2), 16),
                  SizedBox(height: 10,),
                  textRow("Recommended Calories:", actualUserBMR, 16),
                  // SizedBox(height: 10,),
                  // textRow("Medium Exercise:", biasGenerator(1.55), 16),
                  // SizedBox(height: 10,),
                  // textRow("Hard Exercise:", biasGenerator(1.725), 16),
                  SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  textRow("Health Issues:", health, 16),
                  SizedBox(height: 10,),
                  textRow("Goal:", goal + " Weight", 16),
                  SizedBox(height: 10,),
                  // recommendedSection(),
                  // SizedBox(height: 10,),
                  Divider(),
                  SizedBox(height: 10,),
                  inputBox("Breakfast Calorie Goal", breakfastFoodController, "E.g. 120", false),
                  SizedBox(height: 20,),
                  inputBox("Lunch Calorie Goal", lunchFoodController, "E.g. 120", false),
                  SizedBox(height: 20,),
                  inputBox("Dinner Calorie Goal", dinnerFoodController, "E.g. 120", false),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          if (breakfastFoodController.text.isNotEmpty &&
                              lunchFoodController.text.isNotEmpty &&
                              dinnerFoodController.text.isNotEmpty) {
                            setState(() {
                              breakfast = [["", "Loading", "", "", "", "", ""]];
                              lunchfast = [["", "Loading", "", "", "", "", ""]];
                              dinnerfast = [["", "Loading", "", "", "", "", ""]];
                            });
                            getRecommendedRecipes(allergy);
                          } else {
                            Fluttertoast.showToast(
                              msg: "Fill All Fields",
                            );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          decoration: BoxDecoration(
                            color: Color(0xff454B60),
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Recommend",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(),

                  SizedBox(height: 10,),
                  recommendedFood(breakfast, "Breakfast Recommendation"),
                  SizedBox(height: 20,),
                  recommendedFood(lunchfast, "Lunch Recommendation"),
                  SizedBox(height: 20,),
                  recommendedFood(dinnerfast, "Dinner Recommendation"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkValueInSentence(String sentence, String nutrient, double limit) {
    RegExp regExp = RegExp(r'(\d+(\.\d+)?)\s*' + nutrient, caseSensitive: false);
    Iterable<Match> matches = regExp.allMatches(sentence);

    if (matches.isNotEmpty) {
      // Extract the last match
      Match lastMatch = matches.last;
      double extractedValue = double.parse(lastMatch.group(1)!);

      return extractedValue <= limit;
    }

    return false;
  }

  getRecommendedRecipes(String avoid) async {

    List<List<dynamic>> recipes = await nutriBase.getRecipes();

    breakfast = [];
    lunchfast = [];
    dinnerfast = [];



    List<List<dynamic>> closeBreakFastRecipes = recipeListGenerator(recipes, breakfastFoodController);
    List<List<dynamic>> closeLunchRecipes = recipeListGenerator(recipes, lunchFoodController);
    List<List<dynamic>> closeDinnerRecipes = recipeListGenerator(recipes, dinnerFoodController);

    print("Breakfast Recipes found: " + closeBreakFastRecipes.length.toString());
    print("Lunch Recipes found: " + closeLunchRecipes.length.toString());
    print("Dinner Recipes found: " + closeDinnerRecipes.length.toString());

    if (closeBreakFastRecipes.length < 3) {
      Fluttertoast.showToast(
        msg: "Insufficient Breakfast Items in Database",
      );
    }
    if (closeLunchRecipes.length < 3) {
      Fluttertoast.showToast(
        msg: "Insufficient Lunch Items in Database",
      );
    }
    if (closeDinnerRecipes.length < 3) {
      Fluttertoast.showToast(
        msg: "Insufficient Dinner Items in Database",
      );
    }

    Random random = Random();

    for (int i = 0 ; i < 3 ; i++) {

      print("Error");

      int randomBreakfastNumber = random.nextInt(closeBreakFastRecipes.length);
      breakfast.add(closeBreakFastRecipes[randomBreakfastNumber]);
      closeBreakFastRecipes.removeAt(randomBreakfastNumber);

      int randomLunchNumber = random.nextInt(closeLunchRecipes.length);
      lunchfast.add(closeLunchRecipes[randomLunchNumber]);
      closeLunchRecipes.removeAt(randomLunchNumber);

      int randomDinnerNumber = random.nextInt(closeDinnerRecipes.length);
      dinnerfast.add(closeDinnerRecipes[randomDinnerNumber]);
      closeDinnerRecipes.removeAt(randomDinnerNumber);
    }

    setState(() {});
  }

  recipeListGenerator(List<List<dynamic>> recipes, TextEditingController userInput) {
    return recipes.where((recipe) {
      // Check if allergy is not present in ingredients or method
      bool hasNoAllergy =
          !ingredientCheck(recipe[3].toString(), [allergy]) &&
              !ingredientCheck(recipe[4].toString(), [allergy]);

      // Check calorie range and absence of allergy
      if (int.parse(recipe[2]) >= int.parse(userInput.text) * 0.8 &&
          int.parse(recipe[2]) <= int.parse(userInput.text) * 1 &&
          hasNoAllergy) {
        // Health Issue-specific checks
        if (health == 'Hypertension') {
          // Check nutrient values for health issue X
          bool isSodiumWithinLimit = checkValueInSentence(recipe[6].toString(), ' mg Sodium', 700);
          print(isSodiumWithinLimit);
          bool isSFatsWithinLimit = checkValueInSentence(recipe[6].toString(), ' g Saturated Fat', 4.3);
          print(isSFatsWithinLimit);

          // Check for health issue X conditions
          if (isSodiumWithinLimit && isSFatsWithinLimit) {
            return true;
          }
        } else if (health == 'Cardiovascular Disease') {
          print("Check start 2");
          // Check nutrient values for health issue Y
          bool isSodiumWithinLimit = checkValueInSentence(recipe[6].toString(), ' mg Sodium', 665);
          bool isSFatsWithinLimit = checkValueInSentence(recipe[6].toString(), ' g Saturated Fat', 4.3);

          // Check for health issue Y conditions
          if (isSodiumWithinLimit && isSFatsWithinLimit) {
            return true;
          }
        }  else if (health == 'Diabetes') {
          print("Check start 3");
          // Check nutrient values for health issue Y
          bool isCarbsWithinLimit = checkValueInSentence(recipe[6].toString(), ' g Carbohydrates', 60);
          bool isSFatsWithinLimit = checkValueInSentence(recipe[6].toString(), ' g Saturated Fat', 6.5);

          // Check for health issue Y conditions
          if (isCarbsWithinLimit && isSFatsWithinLimit) {
            return true;
          }
        }  else if (health == 'Lactose Intolerance') {
          bool checkIngredients = ingredientCheck(recipe[3].toString(), ["milk", "yoghurt", "yogurt", "cream", "cheese", "butter", "milk,", "yoghurt,", "yogurt,", "cream,", "cheese,", "butter,"]);

          if (checkIngredients == false) {
            return true;
          }
        }  else if (health == 'None') {
          return true;
        }
      }

      return false;
    }).toList();
  }

  bool ingredientCheck(String input, List<String> words) {
    List<String> lines = input.split('\n');

    for (String line in lines) {
      List<String> lineWords = line.toLowerCase().split(' ');
      for (String lineWord in lineWords) {
        for (String word in words) {
          if (word.toLowerCase() == lineWord.toLowerCase()) {
            return true;
          }
        }
      }
    }
    return false;
  }

  workoutCheck(String goal) {
    if (goal == "")
      return 1.0;
	  if (goal == "Sedentary Exercise")
      return 1.2;
    if (goal == "Light Exercise (1-2 Days a week)")
      return 1.375;
    if (goal == "Good Exercise (3-5 Days a week)")
      return 1.55;
    if (goal == "Hard Exercise (6-7 Days a week)")
      return 1.725;
    if (goal == "Extreme Exercise (2x Training)")
      return 1.9;
  }

  recommendedFood(List<List<dynamic>> listOfData, String title) {
    return Column(
      children: [
        textRow(title, "", 16),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listOfData.length,
          itemBuilder: (BuildContext context, int index) {
            return FoodTile(listOfData[index]);
          },
        ),
      ],
    );
  }

  FoodTile(List<dynamic> listOfData) {

    return GestureDetector(
      onTap: () {
        if (listOfData[0] != "") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Recipe(title: listOfData[1], ingredients: listOfData[3], method: listOfData[4], image: listOfData[5], calories: listOfData[2], ID: listOfData[0], nutrients: listOfData[6],)),
          );
        }
        else {
          Fluttertoast.showToast(
            msg: "Recipes not loaded",
          );
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffE8EAF2),
          border: Border.all(color: Color(0xffBFC2CD)),
        ),
        // height: 50,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(listOfData[1],
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xff3D4048),
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text("${listOfData[2]} kCal",
                    style: TextStyle(
                        color: Color(0xff3D4048),
                        fontSize: 14,
                        fontWeight: FontWeight.w800
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 5,),
            Container(
              height: 100,
              width: 100,
              child: listOfData[5] != "" ? Image.network(listOfData[5],
                fit: BoxFit.fitHeight,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[400],
                    ),
                  );
                },
              ) : Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/food_placeholder.png'), fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  recommendedSection() {

    print(userGoal);

    String recommendation = "Loading";
    String foodName = "";
    String foodCal = "";
    String foodUrl = "";

    if (userGoal ==  "Lose") {
      recommendation = "Low Calories";
      foodName = "Salad";
      foodCal = "70";
      foodUrl = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fminimalistbaker.com%2Fwp-content%2Fuploads%2F2014%2F12%2FSIMPLE-satisfying-Spinach-Salad-with-Roasted-Pumpkin-Seeds-and-tons-of-veggies-vegan-glutenfree.jpg&f=1&nofb=1&ipt=ceb0d43a5f629df81be41ee91198f056da01c1ad72ce6cfb7cf67baa9f700f8f&ipo=images";
    }
    else if (userGoal ==  "Maintain") {
      recommendation = "Moderate Calories";
      foodName = "Butter Fish";
      foodCal = "120";
      foodUrl = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.mashed.com%2Fimg%2Fgallery%2Ffish-dishes-so-good-youll-want-to-make-them-every-day%2Fl-intro-1614696518.jpg&f=1&nofb=1&ipt=677cf32f0978347f547e36fd93aa5929766f5eacdb830a3679e60c32b1a2e05f&ipo=images";
    }
    else if (userGoal ==  "Gain") {
      recommendation = "High Calories";
      foodName = "Beef Roast";
      foodCal = "200";
      foodUrl = "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.cheap-chef.com%2Fwp-content%2Fuploads%2F2019%2F04%2FIMG_2089.jpg&f=1&nofb=1&ipt=d1661bd3ee934a7b54c175f664546066ae6552d58a3ed83ec12e6de58d287efa&ipo=images";
    }

    return Column(
      children: [
        textRow("Recommendation: ", recommendation, 18),
        // SizedBox(height: 20,),
        // foodItem(foodName, foodCal, foodUrl),
      ],
    );
  }

  foodItem(String name, String calories, String imageUrl) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffE8EAF2),
        border: Border.all(color: Color(0xffBFC2CD)),
      ),
      // height: 50,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(name,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xff3D4048),
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Text(calories,
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 12,
                      fontWeight: FontWeight.w800
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 5,),
          Container(
            height: 100,
            width: 100,
            child: Image.network(imageUrl,
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  containerCustom() {
    return _image != null ? Container(
        height: 250,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_image!), fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
    ) : Container(
        height: 250,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            Spacer(),
            Icon(Icons.camera_alt_outlined),
            Text(
              "Scan to get calories of food",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300
              ),
            ),
            Spacer(),
          ],
        )
    );
  }

  inputBox(String title, TextEditingController tempController, String hintText, bool rOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: rOnly ? Color(0xffE8EAF2) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Color(0xffBFC2CD),
                  width: 1
              )
          ),
          child: TextField(
            readOnly: rOnly,
            maxLines: 1,
            keyboardType: TextInputType.number,
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            controller: tempController,
            style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
            decoration: new InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: rOnly ? Colors.blueGrey[300] : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  textRow(String title, String value, double size) {
    return Row(
      children: [
        Text(title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff3D4048),
              fontSize: size,
              fontWeight: FontWeight.w400
          ),
        ),
        Spacer(),
        Text(value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff3D4048),
              fontSize: size,
              fontWeight: FontWeight.w800
          ),
        ),
      ],
    );
  }
}