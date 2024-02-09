import 'package:flutter/material.dart';

import '../SubHome.dart';

biasGenerator(double bias) {
  return (userBMR * bias).toStringAsFixed(1);
}

showgoals() {
  return Column(
    children: [
      SizedBox(height: 20,),
      Divider(),
      SizedBox(height: 20,),
      textRow("Daily Calorie Goals", "", 24),
      SizedBox(height: 20,),
      Divider(),
      SizedBox(height: 10,),
      textRow("Light Exercise:", biasGenerator(1.2), 16),
      SizedBox(height: 10,),
      textRow("Medium Exercise:", biasGenerator(1.55), 16),
      SizedBox(height: 10,),
      textRow("Hard Exercise:", biasGenerator(1.725), 16),
      SizedBox(height: 20,),
    ],
  );
}

textRow(String title, String value, double size) {
  return Row(
    children: [
      Text(title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Color(0xff3D4048),
            fontSize: size,
            fontWeight: FontWeight.w400
        ),
      ),
      Spacer(),
      Text(value,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Color(0xff3D4048),
            fontSize: size,
            fontWeight: FontWeight.w800
        ),
      ),
    ],
  );
}