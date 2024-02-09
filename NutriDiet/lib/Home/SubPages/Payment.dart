import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Shopping.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  TextEditingController name = new TextEditingController();
  TextEditingController expiry = new TextEditingController();
  TextEditingController card = new TextEditingController();
  TextEditingController cvv = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
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
                      "Checkout",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xffE8EAF2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffBFC2CD)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Lunch",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 20,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(image: AssetImage('assets/visa.png'), fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(image: AssetImage('assets/mastercard.png'), fit: BoxFit.fill),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: inputBox("Name on Card", name, "E.g. Dave", false, false),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 1,
                              child: inputBox("Expiry", name, "XX/XXXX", false, true),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: inputBox("Card Number", name, "XXXX XXXX XXXX XXXX", false, true),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 1,
                              child: inputBox("CVV", name, "XXX", false, false),
                            ),
                          ],
                        )
                      ],
                    )
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Text(
                      "OR",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xffE8EAF2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffBFC2CD)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Pay with Google Pay",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 20,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: AssetImage('assets/gpay.png'), fit: BoxFit.fill),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xffE8EAF2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffBFC2CD)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Pay with Apple Pay",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(image: AssetImage('assets/applepay.png'), fit: BoxFit.fill),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Fluttertoast.showToast(
                          msg: "Order Placed",
                        );
                        cart = [];
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            color: Color(0xff454B60),
                            border: Border.all(color: Color(0xff454B60)),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text("Pay", style: TextStyle(fontSize: 16, color: Colors.white),),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }

  inputBox(String title, TextEditingController tempController, String hintText, bool rOnly, bool numpad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(height: 5,),
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
            obscureText: false,
            enableSuggestions: true,
            autocorrect: true,
            keyboardType: numpad ? TextInputType.number : TextInputType.text,
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
}
