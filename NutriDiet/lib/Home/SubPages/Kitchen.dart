import 'package:flutter/material.dart';
import 'package:nutridiet/BusinessLogic/Firestore.dart';
import 'package:nutridiet/Home/SubPages/AddRecipe.dart';
import 'package:nutridiet/Home/SubPages/Recipe.dart';

class Kitchen extends StatefulWidget {
  const Kitchen ({super.key});

  @override
  State<Kitchen> createState() => _KitchenState();
}

List<List<dynamic>> food = [];

class _KitchenState extends State<Kitchen> {
  TextEditingController inputController = new TextEditingController();
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    food = await nutriBase.getRecipes();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Text("Recipes", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
              Spacer(),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           padding: EdgeInsets.all(15),
        //           decoration: BoxDecoration(
        //             border: Border.all(color: Color(0xff454B60)),
        //             borderRadius: BorderRadius.circular(15)
        //           ),
        //           child: Row(
        //             children: [
        //               Expanded(
        //                 child: TextField(
        //                   obscureText: false,
        //                   enableSuggestions: true,
        //                   autocorrect: true,
        //                   controller: inputController,
        //                   style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
        //                   decoration: new InputDecoration.collapsed(
        //                     hintText: "Search",
        //                     hintStyle: TextStyle(fontSize: 14, color: Color(0xff454B60)),
        //                   ),
        //                 ),
        //               ),
        //               GestureDetector(
        //                   onTap: () async {
        //
        //                   },
        //                   child: Icon(Icons.search, color: Color(0xff454B60),)
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       SizedBox(width: 20,),
        //       GestureDetector(
        //           onTap: () async {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context) => addRecipe()),
        //             );
        //           },
        //           child: Icon(Icons.add_box_rounded, color: Color(0xff454B60), size: 72,)
        //       ),
        //     ],
        //   ),
        // ),
        isLoaded ? Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: food.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Recipe(title: food[index][1], ingredients: food[index][3], method: food[index][4], image: food[index][5], calories: food[index][2])),
                    );
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
                              Text(food[index][1],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xff3D4048),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                              Text("${food[index][2]} kCal",
                                style: TextStyle(
                                    color: Color(0xff3D4048),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(food[index][5],
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
                  ),
                );
              }
          )
        )  : CircularProgressIndicator(color: Color(0xff454B60),),
      ],
    );
  }
}
