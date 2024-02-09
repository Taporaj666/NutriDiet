import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

class addRecipe extends StatefulWidget {
  const addRecipe({super.key});

  @override
  State<addRecipe> createState() => _addRecipeState();
}

class _addRecipeState extends State<addRecipe> {

  TextEditingController titleController = new TextEditingController();
  TextEditingController ingredientsController = new TextEditingController();
  TextEditingController methodController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  TextEditingController caloriesController = new TextEditingController();
  TextEditingController nutrientController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Color(0xff454B60)),
                  ),
                  Spacer(),
                  Text("Add Recipe", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
                  Spacer(),
                ],
              ),
              SizedBox(height: 40,),
              inputBox("Title of Recipe", titleController, "E.g. Grilled Chicken", 1, false),
              SizedBox(height: 40,),
              inputBox("Calories in Food", caloriesController, "E.g. 160", 1, true),
              SizedBox(height: 20,),
              inputBox("Ingredients Used", ingredientsController, "E.g.\n1 tbps salt\n1 cup flour", 5, false),
              SizedBox(height: 20,),
              inputBox("Method of Recipe", methodController, "E.g.\n1. Prepare the over at 50 degrees\n2. Add oil to flour", 10, false),
              SizedBox(height: 20,),
              inputBox("Nutrients", nutrientController, "E.g.\n2 g Fat\n45 g Cholesterol", 10, false),
              SizedBox(height: 20,),
              inputBox("Image (link)", imageController, "E.g. website.com/chicken.png", 1, false),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: () async {
                  await nutriBase.addRecipe(titleController.text, ingredientsController.text, methodController.text, imageController.text, caloriesController.text, nutrientController.text);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                      color: Color(0xff454B60),
                      border: Border.all(color: Color(0xff454B60)),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  inputBox(String title, TextEditingController tempController, String hintText, int maxLines, bool kbType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color(0xffE8EAF2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Color(0xffBFC2CD),
                  width: 1
              )
          ),
          child: TextField(
            keyboardType: kbType ? TextInputType.number : TextInputType.text,
            maxLines: maxLines,
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            controller: tempController,
            style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
            decoration: new InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey[300]),
            ),
          ),
        ),
      ],
    );
  }
}