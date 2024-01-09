import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/Firestore.dart';

class MonthlyReport extends StatefulWidget {
  const MonthlyReport({super.key});

  @override
  State<MonthlyReport> createState() => _MonthlyReportState();
}

class _MonthlyReportState extends State<MonthlyReport> with RestorationMixin {

  String totalCalories = "Select Day First";
  String totalFat = "";
  String totalSugar = "";
  String totalFiber = "";
  String totalProtein = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> mealData = await nutriBase.getMealDataOfMonth(_selectedDate.value);

    double temp_totalCalories = 0;
    double temp_totalProtein = 0;
    double temp_totalFats = 0;
    double temp_totalSugar = 0;
    double temp_totalFiber = 0;

    for (var meal in mealData) {
      temp_totalCalories += meal['breakfast_calories'] + meal['lunch_calories'] + meal['dinner_calories'];
      temp_totalProtein += meal['breakfast_protein'] + meal['lunch_protein'] + meal['dinner_protein'];
      temp_totalFats += meal['breakfast_fats'] + meal['lunch_fats'] + meal['dinner_fats'];
      temp_totalSugar += meal['breakfast_sugar'] + meal['lunch_sugar'] + meal['dinner_sugar'];
      temp_totalFiber += meal['breakfast_fiber'] + meal['lunch_fiber'] + meal['dinner_fiber'];
    }

    print("Data Loaded: " + mealData.toString());

    setState(() {
      totalCalories = temp_totalCalories.toString();
      totalFat = temp_totalFats.toString();
      totalSugar = temp_totalSugar.toString();
      totalFiber = temp_totalFiber.toString();
      totalProtein = temp_totalProtein.toString();
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
                      " Monthly Report",
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
                textRow("Total Calories:", totalCalories, 24),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 10,),
                textRow("Total Fiber:", totalFiber, 16),
                SizedBox(height: 10,),
                textRow("Total Fats:", totalFat, 16),
                SizedBox(height: 10,),
                textRow("Total Protein:", totalProtein, 16),
                SizedBox(height: 10,),
                textRow("Total Sugar:", totalSugar, 16),
              ],
            )
        ),
      ),
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
}