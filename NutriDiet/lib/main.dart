import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutridiet/Account/Login.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:http/http.dart' as http;

import 'checker.dart';

String API_key = "9f2856f2b9msh0b164651cb5c4f5p12961ajsn08f153e2fead";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // data_migrator(250);

  if (FirebaseAuth.instance.currentUser != null) {
    runApp(const MyApp(forwarder: checker()));
  } else {
    runApp(const MyApp(forwarder: LoginScreen()));
  }
}

String removeHtmlTags(String input) {
  // Replace HTML tags with line breaks
  String result = input.replaceAll(RegExp(r'<.*?>'), '\n');
  // Remove leading and trailing whitespaces
  result = result.trim();
  // Replace consecutive line breaks with a single one
  result = result.replaceAll(RegExp(r'\n+'), '\n');

  // Add line numbers
  List<String> lines = result.split('\n');
  result = lines.asMap().entries.map((entry) => '${entry.key + 1}: ${entry.value}').join('\n');

  return result;
}

String extractIngredientNames(List<dynamic> extendedIngredients) {
  // Extract ingredient names from the "originalName" field
  List<String> ingredientNames = [];
  for (var ingredient in extendedIngredients) {
    if (ingredient is Map<String, dynamic> &&
        ingredient.containsKey("original")) {
      ingredientNames.add(ingredient["original"]);
    }
  }

  // Combine the ingredient names into a single string with newlines
  return ingredientNames.join('\n');
}

int extractCalories(String input) {
  // Regular expression to match patterns like "245 calories"
  RegExp regex = RegExp(r'(\d+)\s+calorie[s]?', caseSensitive: false);

  // Find the first match
  Match? match = regex.firstMatch(input);

  // Extract the matched number of calories
  if (match != null) {
    String caloriesString = match.group(1)!;
    return int.parse(caloriesString);
  } else {
    // Return -1 or another appropriate value if no match is found
    return -1;
  }
}

addNutrients(String ID) async {
  var headers = {
    'X-RapidAPI-Key': API_key,
    'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
  };
  var request = http.Request('GET', Uri.parse('https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/$ID/nutritionWidget.json'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseBody = await response.stream.bytesToString();
    Map<String, dynamic> jsonData = jsonDecode(responseBody);
    List<dynamic>? nutrientsList = jsonData['nutrients'];
    // print(jsonData);
    if (nutrientsList != null && nutrientsList.isNotEmpty) {
      // Format each nutrient entry into a string
      List<String> formattedNutrients = nutrientsList.map((nutrient) {
        String name = nutrient['name'].toString();
        String amount = nutrient['amount'].toString();
        String unit = nutrient['unit'].toString();

        return '$amount $unit $name';
      }).toList();

      // Combine the formatted nutrients into a single string with line separations
      return formattedNutrients.join('\n');
    } else {
      // Return an empty string or another appropriate value if no nutrients are found
      return '';
    }
  }
  else {
  print(response.reasonPhrase);
  }
}

data_migrator(int amount_to_transfer) async {

  print("Starting transfer of $amount_to_transfer recipes");

  var headers = {
    'X-RapidAPI-Key': API_key,
    'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
  };

  var request = http.Request('GET', Uri.parse('https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=$amount_to_transfer'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    try {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonData = jsonDecode(responseBody);

      if (jsonData.containsKey("recipes")) {
        List<dynamic> recipes = jsonData["recipes"];
        for (var item in recipes) {
          String nutrients = await addNutrients(item["id"].toString());
          print(item["id"].toString());
          await nutriBase.addRecipe(
              item["title"],
              extractIngredientNames(item["extendedIngredients"]),
              removeHtmlTags(item["instructions"]), item["image"],
              extractCalories(item["summary"]).toString(),
              nutrients,
          );
          print("Added: " + item["title"]);
        }
        print("$amount_to_transfer recipes transfered to local API");
      } else {
        print("No 'recipes' key found in the JSON response.");
      }
    } catch (error) {
      print("Error parsing JSON: $error");
    }
  }
  else {
  print(response.reasonPhrase);
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