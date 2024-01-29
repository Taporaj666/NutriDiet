import 'package:flutter/Material.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key, required this.title, required this.ingredients, required this.method, required this.image, required this.calories});

  final String title;
  final String calories;
  final String ingredients;
  final String method;
  final String image;

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {

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
                image: NetworkImage("https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn3.tmbi.com%2Fsecure%2FRMS%2Fattachments%2F37%2F1200x1200%2Fexps87236_THCA163696B12_15_3b.jpg&f=1&nofb=1&ipt=de84740a5655da4c28ca93120feba70c11fad2d491fecabe721a789d5518d536&ipo=images"), fit: BoxFit.cover,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
