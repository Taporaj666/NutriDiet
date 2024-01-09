import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutridiet/BusinessLogic/Firestore.dart';
import 'package:nutridiet/Home/SubPages/AddRecipe.dart';
import 'package:nutridiet/Home/SubPages/Recipe.dart';

class AdminKitchen extends StatefulWidget {
  const AdminKitchen ({super.key});

  @override
  State<AdminKitchen> createState() => _KitchenState();
}

List<List<dynamic>> food = [];

class _KitchenState extends State<AdminKitchen> {
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
              Text("Recipes Management", style: TextStyle(fontSize: 24, color: Color(0xff454B60)),),
              Spacer(),
            ],
          ),
        ),
        isLoaded ? Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: food.length,
                itemBuilder: (BuildContext context, int index) {
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
                        GestureDetector(
                          onTap: () async {
                            if (await nutriBase.deleteRecipe(food[index][0])) {
                              setState(() {
                                food.removeAt(index);
                              });
                              Fluttertoast.showToast(
                                msg: "meals added!",
                              );
                            }
                            else {
                              Fluttertoast.showToast(
                                msg: "meals added!",
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.delete_forever, color: Colors.red,),
                          ),
                        )
                      ],
                    ),
                  );
                }
            )
        )  : CircularProgressIndicator(color: Color(0xff454B60),),
      ],
    );
  }
}
