import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutridiet/BusinessLogic/Firestore.dart';
import 'package:nutridiet/Home/SubPages/AddRecipe.dart';
import 'package:nutridiet/Home/SubPages/Recipe.dart';

class Shopping extends StatefulWidget {
  const Shopping ({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

List<List<dynamic>> cart = [];

List<List<dynamic>> buyablefood = [];

class _ShoppingState extends State<Shopping> {
  TextEditingController inputController = new TextEditingController();
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    buyablefood = await nutriBase.getBuyableRecipes();
    print(buyablefood.length);
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
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Icon(Icons.arrow_back, color: Color(0xff454B60)),
              // ),
              Spacer(),
              Text("Buy Food", style: TextStyle(fontSize: 30, color: Color(0xff454B60)),),
              Spacer(),
            ],
          ),
        ),
        isLoaded ? Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: buyablefood.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: "Added item to cart",
                      );
                      cart.add(buyablefood[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xffE8EAF2),
                        border: Border.all(color: Color(0xffBFC2CD)),
                      ),
                      // height: 50,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(buyablefood[index][1].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xff3D4048),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    Text("${buyablefood[index][2]} kCal",
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
                                child: Image.network(buyablefood[index][4].toString(),
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
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text( "Price ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff3D4048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text( buyablefood[index][3].toString() + " USD",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff3D4048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text( "Caterer: ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff3D4048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text( buyablefood[index][6].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff3D4048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text( "Contact: ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff3D4048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text( buyablefood[index][5].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff3D4048),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text( "Add to Cart  ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xff3D4048),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 16,),
                                  ],
                                )
                              ),
                              Spacer(),
                            ],
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
