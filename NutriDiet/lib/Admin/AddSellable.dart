import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

class addSellable extends StatefulWidget {
  const addSellable({super.key});

  @override
  State<addSellable> createState() => _addRecipeState();
}

class _addRecipeState extends State<addSellable> {

  TextEditingController titleController = new TextEditingController();
  TextEditingController calories = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController caterer = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController image = new TextEditingController();

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
                  Text("Add Sellable", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
                  Spacer(),
                ],
              ),
              SizedBox(height: 40,),
              inputBox("Title of Recipe", titleController, "E.g. Grilled Chicken", 1, false),
              SizedBox(height: 20,),
              inputBox("Calories in Food", calories, "E.g. 160", 1, true),
              SizedBox(height: 20,),
              inputBox("Price (USD)", price, "E.g. 25", 1, false),
              SizedBox(height: 20,),
              inputBox("Caterer Name", caterer, "E.g.Ali Foods", 1, false),
              SizedBox(height: 20,),
              inputBox("Caterer Contact", email, "E.g. +392XX or test@test.com", 1, false),
              SizedBox(height: 20,),
              inputBox("Image Link", image, "E.g. website.com/chicken.png", 1, false),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: () async {
                  await nutriBase.addbuyableRecipe(titleController.text, caterer.text, email.text, image.text, int.parse(calories.text), int.parse(price.text));
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