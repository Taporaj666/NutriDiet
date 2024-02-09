import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/Firestore.dart';
import 'package:nutridiet/Home/SubPages/SubHome.dart';

import '../../../Account/SetupWizard.dart';
import 'BiasGoals.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> with RestorationMixin {

  String totalCalories = "Select Day First";
  String calorieGoal = "";
  String totalBreakfastCalories = "";
  String totalLunchCalories = "";
  String totalDinnerCalories = "";
  String totalFat = "";
  String totalSugar = "";
  String totalFiber = "";
  String totalProtein = "";

  String totalCalcium = "";
  String totalCarbs = "";
  String totalIron = "";
  String totalSaturatedFats = "";
  String totalUnsaturatedFats = "";
  String totalMagnesium = "";
  String totalTransFats = "";
  String totalPotassium = "";
  String totalManganese = "";
  String totalSelenium = "";
  String totalSodium = "";
  String totalZinc = "";
  String totalIodine = "";
  String totalVitaminA = "";
  String totalVitaminB1 = "";
  String totalVitaminB2 = "";
  String totalVitaminB5 = "";
  String totalVitaminB6 = "";
  String totalVitaminB7 = "";
  String totalVitaminB9 = "";
  String totalVitaminB12 = "";
  String totalVitaminC = "";
  String totalVitaminD = "";
  String totalVitaminE = "";
  String totalVitaminF = "";
  String totalVitaminK = "";

  String totalVitaminB3 = "";
  String totalChloride = "";
  String totalPhosphorus = "";
  String totalChromium = "";
  String totalCopper = "";
  String totalFluoride = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    loadRecommendation();
  }

  void loadRecommendation() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> userData = await nutriBase.getUserData();
    print(userData.toString());
    if (userData.length == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SetupWizard()),
      );
    }
    setState(() {
      calorieGoal = userData[0].data()["workout"].toString();
    });
  }

  void loadData() async {
    await Future.delayed(Duration(milliseconds: 250));
    List<QueryDocumentSnapshot<Map<String, dynamic>>> mealData = await nutriBase.getMealDataOfDay(_selectedDate.value);

    double temp_totalCalories = 0;
    double temp_totalProtein = 0;
    double temp_totalFats = 0;
    double temp_totalSugar = 0;
    double temp_totalFiber = 0;
    double temp_totalCalcium = 0;
    double temp_totalCarbs = 0;
    double temp_totalIron = 0;
    double temp_totalSaturatedFats = 0;
    double temp_totalUnsaturatedFats = 0;
    double temp_totalMagnesium = 0;
    double temp_totalTransFats = 0;
    double temp_totalPotassium = 0;
    double temp_totalManganese = 0;
    double temp_totalSelenium = 0;
    double temp_totalSodium = 0;
    double temp_totalZinc = 0;
    double temp_totalIodine = 0;
    double temp_totalVitaminA = 0;
    double temp_totalVitaminB1 = 0;
    double temp_totalVitaminB2 = 0;
    double temp_totalVitaminB5 = 0;
    double temp_totalVitaminB6 = 0;
    double temp_totalVitaminB7 = 0;
    double temp_totalVitaminB9 = 0;
    double temp_totalVitaminB12 = 0;
    double temp_totalVitaminC = 0;
    double temp_totalVitaminD = 0;
    double temp_totalVitaminE = 0;
    double temp_totalVitaminF = 0;
    double temp_totalVitaminK = 0;

    double temp_totalVitaminB3 = 0;
    double temp_totalChloride = 0;
    double temp_totalPhosphorus = 0;
    double temp_totalChromium = 0;
    double temp_totalCopper = 0;
    double temp_totalFluoride = 0;

    double temp_totalBreakfastCalories = 0;
    double temp_totalLunchCalories = 0;
    double temp_totalDinnerCalories = 0;

    for (var meal in mealData) {
      temp_totalCalories += meal['breakfast_calories'] + meal['lunch_calories'] + meal['dinner_calories'];
      temp_totalProtein += meal['breakfast_protein'] + meal['lunch_protein'] + meal['dinner_protein'];
      temp_totalFats += meal['breakfast_fats'] + meal['lunch_fats'] + meal['dinner_fats'];
      temp_totalSugar += meal['breakfast_sugar'] + meal['lunch_sugar'] + meal['dinner_sugar'];
      temp_totalFiber += meal['breakfast_fiber'] + meal['lunch_fiber'] + meal['dinner_fiber'];

      setState(() {
        totalCalories = temp_totalCalories.toString();
        totalFat = temp_totalFats.toString();
        totalSugar = temp_totalSugar.toString();
        totalFiber = temp_totalFiber.toString();
        totalProtein = temp_totalProtein.toString();
        totalCalcium = temp_totalCalcium.toString();
        totalCarbs = temp_totalCarbs.toString();
        totalIron = temp_totalIron.toString();
        totalSaturatedFats = temp_totalSaturatedFats.toString();
        totalUnsaturatedFats = temp_totalUnsaturatedFats.toString();
        totalMagnesium = temp_totalMagnesium.toString();
        totalTransFats = temp_totalTransFats.toString();
        totalPotassium = temp_totalPotassium.toString();
        totalManganese = temp_totalManganese.toString();
        totalSelenium = temp_totalSelenium.toString();
        totalSodium = temp_totalSodium.toString();
        totalZinc = temp_totalZinc.toString();
        totalIodine = temp_totalIodine.toString();
        totalVitaminA = temp_totalVitaminA.toString();
        totalVitaminB1 = temp_totalVitaminB1.toString();
        totalVitaminB2 = temp_totalVitaminB2.toString();
        totalVitaminB5 = temp_totalVitaminB5.toString();
        totalVitaminB6 = temp_totalVitaminB6.toString();
        totalVitaminB7 = temp_totalVitaminB7.toString();
        totalVitaminB9 = temp_totalVitaminB9.toString();
        totalVitaminB12 = temp_totalVitaminB12.toString();
        totalVitaminC = temp_totalVitaminC.toString();
        totalVitaminD = temp_totalVitaminD.toString();
        totalVitaminE = temp_totalVitaminE.toString();
        totalVitaminF = temp_totalVitaminF.toString();
        totalVitaminK = temp_totalVitaminK.toString();
        totalBreakfastCalories = temp_totalBreakfastCalories.toString();
        totalLunchCalories = temp_totalLunchCalories.toString();
        totalDinnerCalories = temp_totalDinnerCalories.toString();

        totalVitaminB3 = temp_totalVitaminB3.toString();
        totalChloride = temp_totalChloride.toString();
        totalPhosphorus = temp_totalPhosphorus.toString();
        totalChromium = temp_totalChromium.toString();
        totalCopper = temp_totalCopper.toString();
        totalFluoride = temp_totalFluoride.toString();
      });

      // Breakfast
      temp_totalCalcium += meal['breakfast_calcium'];
      temp_totalCarbs += meal['breakfast_carbs'];
      temp_totalIron += meal['breakfast_iron'];
      temp_totalSaturatedFats += meal['breakfast_saturated_fats'];
      temp_totalUnsaturatedFats += meal['breakfast_unsaturated_fats'];
      temp_totalMagnesium += meal['breakfast_magnesium'];
      temp_totalTransFats += meal['breakfast_trans_fats'];
      temp_totalPotassium += meal['breakfast_potassium'];
      temp_totalManganese += meal['breakfast_manganese'];
      temp_totalSelenium += meal['breakfast_selenium'];
      temp_totalSodium += meal['breakfast_sodium'];
      temp_totalZinc += meal['breakfast_zinc'];
      temp_totalIodine += meal['breakfast_iodine'];
      temp_totalVitaminA += meal['breakfast_vitamin_a'];
      temp_totalVitaminB1 += meal['breakfast_vitamin_b1'];
      temp_totalVitaminB2 += meal['breakfast_vitamin_b2'];
      temp_totalVitaminB5 += meal['breakfast_vitamin_b5'];
      temp_totalVitaminB6 += meal['breakfast_vitamin_b6'];
      temp_totalVitaminB7 += meal['breakfast_vitamin_b7'];
      temp_totalVitaminB9 += meal['breakfast_vitamin_b9'];
      temp_totalVitaminB12 += meal['breakfast_vitamin_b12'];
      temp_totalVitaminC += meal['breakfast_vitamin_c'];
      temp_totalVitaminD += meal['breakfast_vitamin_d'];
      temp_totalVitaminE += meal['breakfast_vitamin_e'];
      temp_totalVitaminF += meal['breakfast_vitamin_f'];
      temp_totalVitaminK += meal['breakfast_vitamin_k'];
      temp_totalVitaminB3 += meal['breakfast_vitamin_b3'];
      temp_totalChloride += meal['breakfast_chloride'];
      temp_totalPhosphorus += meal['breakfast_phosphorus'];
      temp_totalChromium+= meal['breakfast_chromium'];
      temp_totalCopper += meal['breakfast_copper'];
      temp_totalFluoride += meal['breakfast_fluoride'];

      // Lunch
      temp_totalCalcium += meal['lunch_calcium'];
      temp_totalCarbs += meal['lunch_carbs'];
      temp_totalIron += meal['lunch_iron'];
      temp_totalSaturatedFats += meal['lunch_saturated_fats'];
      temp_totalUnsaturatedFats += meal['lunch_unsaturated_fats'];
      temp_totalMagnesium += meal['lunch_magnesium'];
      temp_totalTransFats += meal['lunch_trans_fats'];
      temp_totalPotassium += meal['lunch_potassium'];
      temp_totalManganese += meal['lunch_manganese'];
      temp_totalSelenium += meal['lunch_selenium'];
      temp_totalSodium += meal['lunch_sodium'];
      temp_totalZinc += meal['lunch_zinc'];
      temp_totalIodine += meal['lunch_iodine'];
      temp_totalVitaminA += meal['lunch_vitamin_a'];
      temp_totalVitaminB1 += meal['lunch_vitamin_b1'];
      temp_totalVitaminB2 += meal['lunch_vitamin_b2'];
      temp_totalVitaminB5 += meal['lunch_vitamin_b5'];
      temp_totalVitaminB6 += meal['lunch_vitamin_b6'];
      temp_totalVitaminB7 += meal['lunch_vitamin_b7'];
      temp_totalVitaminB9 += meal['lunch_vitamin_b9'];
      temp_totalVitaminB12 += meal['lunch_vitamin_b12'];
      temp_totalVitaminC += meal['lunch_vitamin_c'];
      temp_totalVitaminD += meal['lunch_vitamin_d'];
      temp_totalVitaminE += meal['lunch_vitamin_e'];
      temp_totalVitaminF += meal['lunch_vitamin_f'];
      temp_totalVitaminK += meal['lunch_vitamin_k'];
      temp_totalVitaminB3 += meal['lunch_vitamin_b3'];
      temp_totalChloride += meal['lunch_chloride'];
      temp_totalPhosphorus += meal['lunch_phosphorus'];
      temp_totalChromium+= meal['lunch_chromium'];
      temp_totalCopper += meal['lunch_copper'];
      temp_totalFluoride += meal['lunch_fluoride'];

      // Dinner
      temp_totalCalcium += meal['dinner_calcium'];
      temp_totalCarbs += meal['dinner_carbs'];
      temp_totalIron += meal['dinner_iron'];
      temp_totalSaturatedFats += meal['dinner_saturated_fats'];
      temp_totalUnsaturatedFats += meal['dinner_unsaturated_fats'];
      temp_totalMagnesium += meal['dinner_magnesium'];
      temp_totalTransFats += meal['dinner_trans_fats'];
      temp_totalPotassium += meal['dinner_potassium'];
      temp_totalManganese += meal['dinner_manganese'];
      temp_totalSelenium += meal['dinner_selenium'];
      temp_totalSodium += meal['dinner_sodium'];
      temp_totalZinc += meal['dinner_zinc'];
      temp_totalIodine += meal['dinner_iodine'];
      temp_totalVitaminA += meal['dinner_vitamin_a'];
      temp_totalVitaminB1 += meal['dinner_vitamin_b1'];
      temp_totalVitaminB2 += meal['dinner_vitamin_b2'];
      temp_totalVitaminB5 += meal['dinner_vitamin_b5'];
      temp_totalVitaminB6 += meal['dinner_vitamin_b6'];
      temp_totalVitaminB7 += meal['dinner_vitamin_b7'];
      temp_totalVitaminB9 += meal['dinner_vitamin_b9'];
      temp_totalVitaminB12 += meal['dinner_vitamin_b12'];
      temp_totalVitaminC += meal['dinner_vitamin_c'];
      temp_totalVitaminD += meal['dinner_vitamin_d'];
      temp_totalVitaminE += meal['dinner_vitamin_e'];
      temp_totalVitaminF += meal['dinner_vitamin_f'];
      temp_totalVitaminK += meal['dinner_vitamin_k'];
      temp_totalVitaminB3 += meal['dinner_vitamin_b3'];
      temp_totalChloride += meal['dinner_chloride'];
      temp_totalPhosphorus += meal['dinner_phosphorus'];
      temp_totalChromium+= meal['dinner_chromium'];
      temp_totalCopper += meal['dinner_copper'];
      temp_totalFluoride += meal['dinner_fluoride'];

      temp_totalBreakfastCalories += meal['breakfast_calories'];
      temp_totalLunchCalories += meal['lunch_calories'];
      temp_totalDinnerCalories += meal['dinner_calories'];
    }

    print("Data Loaded: " + mealData.toString());

    setState(() {
      totalCalories = temp_totalCalories.toString();
      totalFat = temp_totalFats.toString();
      totalSugar = temp_totalSugar.toString();
      totalFiber = temp_totalFiber.toString();
      totalProtein = temp_totalProtein.toString();
      totalCalcium = temp_totalCalcium.toString();
      totalCarbs = temp_totalCarbs.toString();
      totalIron = temp_totalIron.toString();
      totalSaturatedFats = temp_totalSaturatedFats.toString();
      totalUnsaturatedFats = temp_totalUnsaturatedFats.toString();
      totalMagnesium = temp_totalMagnesium.toString();
      totalTransFats = temp_totalTransFats.toString();
      totalPotassium = temp_totalPotassium.toString();
      totalManganese = temp_totalManganese.toString();
      totalSelenium = temp_totalSelenium.toString();
      totalSodium = temp_totalSodium.toString();
      totalZinc = temp_totalZinc.toString();
      totalIodine = temp_totalIodine.toString();
      totalVitaminA = temp_totalVitaminA.toString();
      totalVitaminB1 = temp_totalVitaminB1.toString();
      totalVitaminB2 = temp_totalVitaminB2.toString();
      totalVitaminB5 = temp_totalVitaminB5.toString();
      totalVitaminB6 = temp_totalVitaminB6.toString();
      totalVitaminB7 = temp_totalVitaminB7.toString();
      totalVitaminB9 = temp_totalVitaminB9.toString();
      totalVitaminB12 = temp_totalVitaminB12.toString();
      totalVitaminC = temp_totalVitaminC.toString();
      totalVitaminD = temp_totalVitaminD.toString();
      totalVitaminE = temp_totalVitaminE.toString();
      totalVitaminF = temp_totalVitaminF.toString();
      totalVitaminK = temp_totalVitaminK.toString();
      totalBreakfastCalories = temp_totalBreakfastCalories.toString();
      totalLunchCalories = temp_totalLunchCalories.toString();
      totalDinnerCalories = temp_totalDinnerCalories.toString();

      totalVitaminB3 = temp_totalVitaminB3.toString();
      totalChloride = temp_totalChloride.toString();
      totalPhosphorus = temp_totalPhosphorus.toString();
      totalChromium = temp_totalChromium.toString();
      totalCopper = temp_totalCopper.toString();
      totalFluoride = temp_totalFluoride.toString();
    });
  }

  @override
  String? get restorationId => "";

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        loadData();
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  workoutCheck(String goal) {
    if (goal == "")
      return 1.0;
    if (goal == "Sedentary Exercise")
      return 1.2;
    if (goal == "Light Exercise (1-2 Days a week)")
      return 1.375;
    if (goal == "Good Exercise (3-5 Days a week)")
      return 1.55;
    if (goal == "Hard Exercise (6-7 Days a week)")
      return 1.725;
    if (goal == "Extreme Exercise (2x Training)")
      return 1.9;
  }

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
                      " Daily Report",
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
                    _restorableDatePickerRouteFuture.present();
                  },
                  child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Color(0xffE8EAF2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color(0xffBFC2CD),
                              width: 1
                          )
                      ),
                      child: Row(
                        children: [
                          Text("Selected Day: " + _selectedDate.value.day.toString() + "-" + _selectedDate.value.month.toString() + "-" + _selectedDate.value.year.toString()),
                          Spacer(),
                          Text(
                            "Change",
                            style: TextStyle(
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(height: 50,),
                textRow("Total Calories:", totalCalories, 16, 'kCal'),
                SizedBox(height: 10,),
                textRow("Daily Calorie Goal:", actualUserBMR, 16, 'kCal'),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                textRow("Total Breakfast Calories:", totalBreakfastCalories, 16, 'kCal'),
                SizedBox(height: 10,),
                textRow("Total Lunch Calories:", totalLunchCalories, 16, 'kCal'),
                SizedBox(height: 10,),
                textRow("Total Dinner Calories:", totalDinnerCalories, 16, 'kCal'),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                textRow("Total Fiber:", totalFiber, 16, 'g'),
                SizedBox(height: 10,),
                textRow("Total Fats:", totalFat, 16, 'g'),
                SizedBox(height: 10,),
                textRow("Total Protein:", totalProtein, 16, 'g'),
                SizedBox(height: 10,),
                textRow("Total Carbs:", totalCarbs, 16, 'g'),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                textRow("Total Calcium:", totalCalcium, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Sugar:", totalSugar, 16, 'g'),

                SizedBox(height: 10,),
                textRow("Total Iron:", totalIron, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Saturated Fats:", totalSaturatedFats, 16, 'g'),

                SizedBox(height: 10,),
                textRow("Total Unsaturated Fats:", totalUnsaturatedFats, 16, 'g'),

                SizedBox(height: 10,),
                textRow("Total Magnesium:", totalMagnesium, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Trans Fats:", totalTransFats, 16, 'g'),

                SizedBox(height: 10,),
                textRow("Total Potassium:", totalPotassium, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Manganese:", totalManganese, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Selenium:", totalSelenium, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Sodium:", totalSodium, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Zinc:", totalZinc, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Iodine:", totalIodine, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin A:", totalVitaminA, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B1:", totalVitaminB1, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B2:", totalVitaminB2, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B3:", totalVitaminB3, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B5:", totalVitaminB5, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B6:", totalVitaminB6, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B7:", totalVitaminB7, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B9:", totalVitaminB9, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin B12:", totalVitaminB12, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin C:", totalVitaminC, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin D:", totalVitaminD, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin E:", totalVitaminE, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Vitamin K:", totalVitaminK, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Molybdenum:", totalVitaminF, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Chloride:", totalChloride, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Copper:", totalCopper, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Chromium:", totalChromium, 16, 'µg'),

                SizedBox(height: 10,),
                textRow("Total Phosphorus:", totalPhosphorus, 16, 'mg'),

                SizedBox(height: 10,),
                textRow("Total Fluoride:", totalFluoride, 16, 'mg'),
                // showgoals(),
              ],
            )
        ),
      ),
    );
  }

  textRow(String title, String value, double size, String units) {
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
        Text(" $units",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Color(0xff3D4048),
              fontSize: size,
              fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}