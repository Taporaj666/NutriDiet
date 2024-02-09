import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutridiet/Home/SubPages/Payment.dart';

import 'Shopping.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)
                    ),
                    Text(
                      " Cart",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if (cart.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Payment()),
                          );
                        }
                        else {
                          Fluttertoast.showToast(
                            msg: "Cart is Empty",
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            color: Color(0xff454B60),
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Checkout", style: TextStyle(fontSize: 16, color: Colors.white),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffE8EAF2),
                    border: Border.all(color: Color(0xffBFC2CD)),
                  ),
                  // height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Item",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color(0xff3D4048),
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      Text( "Price ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xff3D4048),
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text("Delete",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xff3D4048),
                            fontSize: 16,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Divider(),
                SizedBox(height: 20,),
                Expanded(
                    child: ListView.builder(
                        // padding: const EdgeInsets.all(20),
                        itemCount: cart.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(10),
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
                                      Text(cart[index][1].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0xff3D4048),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      Text("${cart[index][2]} kCal",
                                        style: TextStyle(
                                            color: Color(0xff3D4048),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                                SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                      msg: "Deleted item",
                                    );
                                    setState(() {
                                      cart.removeAt(index);
                                    });
                                  },
                                  child: Icon(Icons.delete_forever, color: Colors.red,),
                                )
                              ],
                            ),
                          );
                        }
                    )
                )
              ],
            )
        ),
      ),
    );
  }
}