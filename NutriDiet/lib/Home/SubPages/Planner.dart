import 'package:flutter/Material.dart';

class FoodPlanner extends StatelessWidget {
  const FoodPlanner({super.key});

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
                      " Food Logging and Tracking",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
              ],
            )
        ),
      ),
    );
  }
}
