import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';

class FoodLogging extends StatefulWidget {
  const FoodLogging({super.key});
  @override
  State<FoodLogging> createState() => _FoodLoggingState() ;
}

class _FoodLoggingState extends State<FoodLogging> with RestorationMixin {

  TextEditingController breakfastFoodController = new TextEditingController();
  TextEditingController breakfastCaloriesController = new TextEditingController();
  TextEditingController breakfastProteinController = new TextEditingController();
  TextEditingController breakfastSugarController = new TextEditingController();
  TextEditingController breakfastFatsController = new TextEditingController();
  TextEditingController breakfastFiberController = new TextEditingController();

  TextEditingController lunchFoodController = new TextEditingController();
  TextEditingController lunchCaloriesController = new TextEditingController();
  TextEditingController lunchProteinController = new TextEditingController();
  TextEditingController lunchSugarController = new TextEditingController();
  TextEditingController lunchFatsController = new TextEditingController();
  TextEditingController lunchFiberController = new TextEditingController();

  TextEditingController dinnerFoodController = new TextEditingController();
  TextEditingController dinnerCaloriesController = new TextEditingController();
  TextEditingController dinnerProteinController = new TextEditingController();
  TextEditingController dinnerSugarController = new TextEditingController();
  TextEditingController dinnerFatsController = new TextEditingController();
  TextEditingController dinnerFiberController = new TextEditingController();

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
        child: Scaffold(
          body: Container(
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
                  SizedBox(height: 20,),
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
                        Text(
                          "Breakfast",
                          style: TextStyle(
                            fontSize: 24,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 20,),
                        inputBox("Food Consumed", breakfastFoodController, "E.g. Biryani", false, false),
                        SizedBox(height: 10,),
                        inputBox("Calories", breakfastCaloriesController, "E.g. 120", false, true),
                        SizedBox(height: 20,),
                        Text(
                          "Nutrition",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: nutritionBox("Protien", "g", breakfastProteinController, "E.g. 5"),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: nutritionBox("Sugar  ", "g", breakfastSugarController, "E.g. 5"),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: nutritionBox("Fats    ", "g", breakfastFatsController, "E.g. 5"),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: nutritionBox("Fiber   ", "g", breakfastFiberController, "E.g. 5"),
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 20,),
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
                          Text(
                            "Lunch",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20,),
                          inputBox("Food Consumed", lunchFoodController, "E.g. Biryani", false, false),
                          SizedBox(height: 10,),
                          inputBox("Calories", lunchCaloriesController, "E.g. 120", false, true),
                          SizedBox(height: 20,),
                          Text(
                            "Nutrition",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: nutritionBox("Protien", "g", lunchProteinController, "E.g. 5"),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: nutritionBox("Sugar  ", "g", lunchSugarController, "E.g. 5"),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: nutritionBox("Fats    ", "g", lunchFatsController, "E.g. 5"),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: nutritionBox("Fiber   ", "g", lunchFiberController, "E.g. 5"),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 20,),
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
                          Text(
                            "Dinner",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20,),
                          inputBox("Food Consumed", dinnerFoodController, "E.g. Biryani", false, false),
                          SizedBox(height: 10,),
                          inputBox("Calories", dinnerCaloriesController, "E.g. 120", false, true),
                          SizedBox(height: 20,),
                          Text(
                            "Nutrition",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: nutritionBox("Protien", "g", dinnerProteinController, "E.g. 5"),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: nutritionBox("Sugar  ", "g", dinnerSugarController, "E.g. 5"),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(
                                child: nutritionBox("Fats    ", "g", dinnerFatsController, "E.g. 5"),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: nutritionBox("Fiber   ", "g", dinnerFiberController, "E.g. 5"),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await nutriBase.addDay(_selectedDate.value, int.parse(breakfastCaloriesController.text), int.parse(breakfastProteinController.text), int.parse(breakfastSugarController.text), int.parse(breakfastFatsController.text), int.parse(breakfastFiberController.text), int.parse(lunchCaloriesController.text), int.parse(lunchProteinController.text), int.parse(lunchSugarController.text), int.parse(lunchFatsController.text), int.parse(lunchFiberController.text), int.parse(dinnerCaloriesController.text), int.parse(dinnerProteinController.text), int.parse(dinnerSugarController.text), int.parse(dinnerFatsController.text), int.parse(dinnerFiberController.text));
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                          decoration: BoxDecoration(
                              color: Color(0xff454B60),
                              border: Border.all(color: Color(0xff454B60)),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text("Add Log", style: TextStyle(fontSize: 16, color: Colors.white),),
                        ),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  inputBox(String title, TextEditingController tempController, String hintText, bool rOnly, bool numpad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(height: 10,),
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

  nutritionBox(String title, String units, TextEditingController tempController, String hintText) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
        SizedBox(width: 5,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Color(0xffBFC2CD),
                    width: 1
                )
            ),
            child: TextField(
              readOnly: false,
              keyboardType: TextInputType.number,
              maxLines: 1,
              obscureText: false,
              enableSuggestions: true,
              autocorrect: true,
              controller: tempController,
              style: TextStyle(fontSize: 14, color: Color(0xff454B60)),
              decoration: new InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
        ),
        SizedBox(width: 5,),
        Text(units, style: TextStyle(fontSize: 16, color: Color(0xff454B60)),),
      ],
    );
  }
}