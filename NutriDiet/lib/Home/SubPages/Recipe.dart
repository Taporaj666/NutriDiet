import 'package:flutter/Material.dart';

import '../../Account/Login.dart';
import '../../BusinessLogic/Firebase.dart';
import 'Payment.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key, required this.title, required this.ingredients, required this.method, required this.image, required this.calories, required this.ID, required this.nutrients});

  final String ID;
  final String title;
  final String calories;
  final String ingredients;
  final String method;
  final String image;
  final String nutrients;

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

  TextEditingController IDController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IDController.text = widget.ID;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Color(0xff454B60)),
                ),
                Spacer(),
                Text("Recipe", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
                Spacer(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40),
            height: MediaQuery.of(context).size.width * 0.75,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffE8EAF2),
              border: Border.all(color: Color(0xffBFC2CD)),
              image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.title} (${widget.calories}kCal)",
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                // SizedBox(height: 20,),
                // Row(
                //   children: [
                //     SizedBox(
                //         width: 100,
                //         child: Text("Recipe ID:", style: TextStyle(fontSize: 12, color: Color(0xff454B60)),)
                //     ),
                //     SizedBox(width: 20,),
                //     Expanded(
                //       child: TextField(
                //         readOnly: true,
                //         keyboardType: TextInputType.text,
                //         obscureText: false,
                //         enableSuggestions: true,
                //         autocorrect: true,
                //         controller: IDController,
                //         style: TextStyle(fontSize: 12, color: Color(0xff454B60)),
                //         decoration: new InputDecoration.collapsed(
                //           hintText: "Enter Data",
                //           hintStyle: TextStyle(fontSize: 12, color: Color(0xff454B60)),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Payment()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            color: Color(0xff454B60),
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Buy Now, USD \$10", style: TextStyle(fontSize: 16, color: Colors.white),),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Ingredients",
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                  ),
                ),
                SizedBox(height: 20,),
                Text(widget.ingredients,
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5
                  ),
                ),
                SizedBox(height: 20,),
                Text("Method of Preparation",
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 20,),
                Text(widget.method,
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5
                  ),
                ),
                SizedBox(height: 20,),
                Text("Nutrients",
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 20,),
                Text(widget.nutrients,
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5
                  ),
                ),
                SizedBox(height: 20,),
                Divider(),
                SizedBox(height: 20,),
                Text("Comments",
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 20,),
                CommentBox("Anonymous", "I tried out this recipe, it is very well balanced"),
                SizedBox(height: 20,),
                CommentBox("Anonymous", "It is a perfect meal for when you have guests over"),
              ],
            ),
          )
        ],
      ),
    );
  }

  CommentBox(String name, String comment) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Icon(Icons.person, color: Colors.white, size: 24,),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(name,
                      style: TextStyle(
                          color: Color(0xff3D4048),
                          fontSize: 20,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(
                      child: Text(comment,
                        style: TextStyle(
                          color: Color(0xff3D4048),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
