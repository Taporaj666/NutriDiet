import 'package:flutter/Material.dart';
import 'package:nutridiet/Home/SubPages/Reports/Daily.dart';
import 'package:nutridiet/Home/SubPages/Reports/Monthly.dart';

import 'Reports/Calory.dart';

class Dietary extends StatelessWidget {
  const Dietary({super.key});

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
                      " Dietary Assessment",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DailyReport()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xffE8EAF2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffBFC2CD)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Daily Report",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(image: AssetImage('assets/report.png'), fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MonthlyReport()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xffE8EAF2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffBFC2CD)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Monthly Report",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(image: AssetImage('assets/report.png'), fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GraphPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xffE8EAF2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffBFC2CD)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Calory Graph",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(image: AssetImage('assets/report.png'), fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
