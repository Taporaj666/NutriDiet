import 'package:flutter/Material.dart';
import 'package:nutridiet/BusinessLogic/FireStore.dart';
import 'package:nutridiet/BusinessLogic/ImageHelper.dart';
import 'package:nutridiet/BusinessLogic/utils.dart';
import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image/image.dart' as IMG;
import 'dart:convert';
import 'dart:math';

class FoodLogging extends StatefulWidget {
  const FoodLogging({super.key});
  @override
  State<FoodLogging> createState() => _FoodLoggingState() ;
}

class _FoodLoggingState extends State<FoodLogging> with RestorationMixin {

  TextEditingController breakfastFoodController = new TextEditingController();
  TextEditingController breakfastCaloriesController = new TextEditingController();
  TextEditingController breakfastProteinController = TextEditingController();
  TextEditingController breakfastSugarController = TextEditingController();
  TextEditingController breakfastFatsController = TextEditingController();
  TextEditingController breakfastFiberController = TextEditingController();
  TextEditingController breakfastCalciumController = TextEditingController();
  TextEditingController breakfastCarbsController = TextEditingController();
  TextEditingController breakfastIronController = TextEditingController();
  TextEditingController breakfastSaturatedFatsController = TextEditingController();
  TextEditingController breakfastUnsaturatedFatsController = TextEditingController();
  TextEditingController breakfastMagnesiumController = TextEditingController();
  TextEditingController breakfastTransFatsController = TextEditingController();
  TextEditingController breakfastPotassiumController = TextEditingController();
  TextEditingController breakfastManganeseController = TextEditingController();
  TextEditingController breakfastSeleniumController = TextEditingController();
  TextEditingController breakfastSodiumController = TextEditingController();
  TextEditingController breakfastZincController = TextEditingController();
  TextEditingController breakfastIodineController = TextEditingController();
  TextEditingController breakfastMolybdenumController = TextEditingController();
  TextEditingController breakfastVitaminAController = TextEditingController();
  TextEditingController breakfastVitaminB1Controller = TextEditingController();
  TextEditingController breakfastVitaminB2Controller = TextEditingController();
  TextEditingController breakfastVitaminB5Controller = TextEditingController();
  TextEditingController breakfastVitaminB6Controller = TextEditingController();
  TextEditingController breakfastVitaminB7Controller = TextEditingController();
  TextEditingController breakfastVitaminB9Controller = TextEditingController();
  TextEditingController breakfastVitaminB12Controller = TextEditingController();
  TextEditingController breakfastVitaminCController = TextEditingController();
  TextEditingController breakfastVitaminDController = TextEditingController();
  TextEditingController breakfastVitaminEController = TextEditingController();
  TextEditingController breakfastVitaminFController = TextEditingController();
  TextEditingController breakfastVitaminKController = TextEditingController();
  
  // missing fields added later
  
  TextEditingController breakfastVitaminB3Controller = TextEditingController();
  TextEditingController breakfastChlorideController = TextEditingController();
  TextEditingController breakfastCopperController = TextEditingController();
  TextEditingController breakfastChromiumController = TextEditingController();
  TextEditingController breakfastPhosphorusController = TextEditingController();
  TextEditingController breakfastFluorideController = TextEditingController();

  TextEditingController lunchFoodController = new TextEditingController();
  TextEditingController lunchCaloriesController = new TextEditingController();
  TextEditingController lunchProteinController = TextEditingController();
  TextEditingController lunchSugarController = TextEditingController();
  TextEditingController lunchFatsController = TextEditingController();
  TextEditingController lunchFiberController = TextEditingController();
  TextEditingController lunchCalciumController = TextEditingController();
  TextEditingController lunchCarbsController = TextEditingController();
  TextEditingController lunchIronController = TextEditingController();
  TextEditingController lunchSaturatedFatsController = TextEditingController();
  TextEditingController lunchUnsaturatedFatsController = TextEditingController();
  TextEditingController lunchMagnesiumController = TextEditingController();
  TextEditingController lunchTransFatsController = TextEditingController();
  TextEditingController lunchPotassiumController = TextEditingController();
  TextEditingController lunchManganeseController = TextEditingController();
  TextEditingController lunchSeleniumController = TextEditingController();
  TextEditingController lunchSodiumController = TextEditingController();
  TextEditingController lunchZincController = TextEditingController();
  TextEditingController lunchIodineController = TextEditingController();
  TextEditingController lunchMolybdenumController = TextEditingController();
  TextEditingController lunchVitaminAController = TextEditingController();
  TextEditingController lunchVitaminB1Controller = TextEditingController();
  TextEditingController lunchVitaminB2Controller = TextEditingController();
  TextEditingController lunchVitaminB5Controller = TextEditingController();
  TextEditingController lunchVitaminB6Controller = TextEditingController();
  TextEditingController lunchVitaminB7Controller = TextEditingController();
  TextEditingController lunchVitaminB9Controller = TextEditingController();
  TextEditingController lunchVitaminB12Controller = TextEditingController();
  TextEditingController lunchVitaminCController = TextEditingController();
  TextEditingController lunchVitaminDController = TextEditingController();
  TextEditingController lunchVitaminEController = TextEditingController();
  TextEditingController lunchVitaminFController = TextEditingController();
  TextEditingController lunchVitaminKController = TextEditingController();

  // missing fields added later
  
  TextEditingController lunchVitaminB3Controller = TextEditingController();
  TextEditingController lunchChlorideController = TextEditingController();
  TextEditingController lunchCopperController = TextEditingController();
  TextEditingController lunchChromiumController = TextEditingController();
  TextEditingController lunchPhosphorusController = TextEditingController();
  TextEditingController lunchFluorideController = TextEditingController();

  TextEditingController dinnerFoodController = new TextEditingController();
  TextEditingController dinnerCaloriesController = new TextEditingController();
  TextEditingController dinnerProteinController = TextEditingController();
  TextEditingController dinnerSugarController = TextEditingController();
  TextEditingController dinnerFatsController = TextEditingController();
  TextEditingController dinnerFiberController = TextEditingController();
  TextEditingController dinnerCalciumController = TextEditingController();
  TextEditingController dinnerCarbsController = TextEditingController();
  TextEditingController dinnerIronController = TextEditingController();
  TextEditingController dinnerSaturatedFatsController = TextEditingController();
  TextEditingController dinnerUnsaturatedFatsController = TextEditingController();
  TextEditingController dinnerMagnesiumController = TextEditingController();
  TextEditingController dinnerTransFatsController = TextEditingController();
  TextEditingController dinnerPotassiumController = TextEditingController();
  TextEditingController dinnerManganeseController = TextEditingController();
  TextEditingController dinnerSeleniumController = TextEditingController();
  TextEditingController dinnerSodiumController = TextEditingController();
  TextEditingController dinnerZincController = TextEditingController();
  TextEditingController dinnerIodineController = TextEditingController();
  TextEditingController dinnerMolybdenumController = TextEditingController();
  TextEditingController dinnerVitaminAController = TextEditingController();
  TextEditingController dinnerVitaminB1Controller = TextEditingController();
  TextEditingController dinnerVitaminB2Controller = TextEditingController();
  TextEditingController dinnerVitaminB5Controller = TextEditingController();
  TextEditingController dinnerVitaminB6Controller = TextEditingController();
  TextEditingController dinnerVitaminB7Controller = TextEditingController();
  TextEditingController dinnerVitaminB9Controller = TextEditingController();
  TextEditingController dinnerVitaminB12Controller = TextEditingController();
  TextEditingController dinnerVitaminCController = TextEditingController();
  TextEditingController dinnerVitaminDController = TextEditingController();
  TextEditingController dinnerVitaminEController = TextEditingController();
  TextEditingController dinnerVitaminFController = TextEditingController();
  TextEditingController dinnerVitaminKController = TextEditingController();

  // missing fields added later
  
  TextEditingController dinnerVitaminB3Controller = TextEditingController();
  TextEditingController dinnerChlorideController = TextEditingController();
  TextEditingController dinnerCopperController = TextEditingController();
  TextEditingController dinnerChromiumController = TextEditingController();
  TextEditingController dinnerPhosphorusController = TextEditingController();
  TextEditingController dinnerFluorideController = TextEditingController();

  final imageHelper = ImageHelper();
  late ImageLabeler _imageLabeler;
  File? _image;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  String title = "---";
  String calories = "---";
  String description = "---";

  @override
  String? get restorationId => "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeLabeler();
  }

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

  randomCalories() async {
    setState(() {
      title = "Searching...";
    });
    await Future.delayed(Duration(seconds: 3));
    Random random = new Random();
    int randomNumber = random.nextInt(30) + 105;
    setState(() {
      title = "Strawberry";
      calories = randomNumber.toString();
      description = "No Description available for this food item";
    });
  }

  startImageSearch() async {
    setState(() {
      title = "Searching...";
    });

    await _processImage(InputImage.fromFilePath(_image!.path));
    print(_text);
  }

  void _initializeLabeler() async {
    final path = 'assets/ml/object_labeler.tflite';
    final modelPath = await getAssetPath(path);
    final options = LocalLabelerOptions(modelPath: modelPath);
    _imageLabeler = ImageLabeler(options: options);
    _canProcess = true;
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final labels = await _imageLabeler.processImage(inputImage);
    String text = 'Labels found: ${labels.length}\n\n';
    for (final label in labels) {
      text += 'Label: ${label.label}, '
          'Confidence: ${label.confidence.toStringAsFixed(2)}\n\n';
    }
    _text = text;
    _customPaint = null;
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

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
                  GestureDetector(
                    onTap: () async {
                      final file = await imageHelper.pickImage();
                      if (file! != null) {
                        print(file!.path);
                        final croppedFile = await imageHelper.cropImage(file: file);
                        if (croppedFile! != null) {
                          setState(() {
                            _image = File(croppedFile!.path);
                          });
                          setState(() {
                            calories = "Loading";
                          });
                          randomCalories();
                        }
                      }
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
                            Text(
                              overflow: TextOverflow.ellipsis,
                              "Calories: $calories",
                            ),
                            Spacer(),
                            Icon(Icons.camera_alt_rounded)
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  sectionEntryArea(
                    "Breakfast",
                    breakfastFoodController,
                    breakfastCaloriesController,
                    breakfastProteinController,
                    breakfastSugarController,
                    breakfastFatsController,
                    breakfastFiberController,
                    breakfastCalciumController,
                    breakfastCarbsController,
                    breakfastIronController,
                    breakfastSaturatedFatsController,
                    breakfastUnsaturatedFatsController,
                    breakfastMagnesiumController,
                    breakfastTransFatsController,
                    breakfastPotassiumController,
                    breakfastManganeseController,
                    breakfastSeleniumController,
                    breakfastSodiumController,
                    breakfastZincController,
                    breakfastIodineController,
                    breakfastVitaminAController,
                    breakfastVitaminB1Controller,
                    breakfastVitaminB2Controller,
                    breakfastVitaminB5Controller,
                    breakfastVitaminB6Controller,
                    breakfastVitaminB7Controller,
                    breakfastVitaminB9Controller,
                    breakfastVitaminB12Controller,
                    breakfastVitaminCController,
                    breakfastVitaminDController,
                    breakfastVitaminEController,
                    breakfastVitaminFController,
                    breakfastVitaminKController,
                    breakfastVitaminB3Controller,
                    breakfastChlorideController,
                    breakfastPhosphorusController,
                    breakfastChromiumController,
                    breakfastCopperController,
                    breakfastFluorideController,
                  ),
                  SizedBox(height: 20,),
                  sectionEntryArea(
                    "Lunch",
                    lunchFoodController,
                    lunchCaloriesController,
                    lunchProteinController,
                    lunchSugarController,
                    lunchFatsController,
                    lunchFiberController,
                    lunchCalciumController,
                    lunchCarbsController,
                    lunchIronController,
                    lunchSaturatedFatsController,
                    lunchUnsaturatedFatsController,
                    lunchMagnesiumController,
                    lunchTransFatsController,
                    lunchPotassiumController,
                    lunchManganeseController,
                    lunchSeleniumController,
                    lunchSodiumController,
                    lunchZincController,
                    lunchIodineController,
                    lunchVitaminAController,
                    lunchVitaminB1Controller,
                    lunchVitaminB2Controller,
                    lunchVitaminB5Controller,
                    lunchVitaminB6Controller,
                    lunchVitaminB7Controller,
                    lunchVitaminB9Controller,
                    lunchVitaminB12Controller,
                    lunchVitaminCController,
                    lunchVitaminDController,
                    lunchVitaminEController,
                    lunchVitaminFController,
                    lunchVitaminKController,
                    lunchVitaminB3Controller,
                    lunchChlorideController,
                    lunchPhosphorusController,
                    lunchChromiumController,
                    lunchCopperController,
                    lunchFluorideController,
                  ),
                  SizedBox(height: 20,),
                  sectionEntryArea(
                    "Dinner",
                    dinnerFoodController,
                    dinnerCaloriesController,
                    dinnerProteinController,
                    dinnerSugarController,
                    dinnerFatsController,
                    dinnerFiberController,
                    dinnerCalciumController,
                    dinnerCarbsController,
                    dinnerIronController,
                    dinnerSaturatedFatsController,
                    dinnerUnsaturatedFatsController,
                    dinnerMagnesiumController,
                    dinnerTransFatsController,
                    dinnerPotassiumController,
                    dinnerManganeseController,
                    dinnerSeleniumController,
                    dinnerSodiumController,
                    dinnerZincController,
                    dinnerIodineController,
                    dinnerVitaminAController,
                    dinnerVitaminB1Controller,
                    dinnerVitaminB2Controller,
                    dinnerVitaminB5Controller,
                    dinnerVitaminB6Controller,
                    dinnerVitaminB7Controller,
                    dinnerVitaminB9Controller,
                    dinnerVitaminB12Controller,
                    dinnerVitaminCController,
                    dinnerVitaminDController,
                    dinnerVitaminEController,
                    dinnerVitaminFController,
                    dinnerVitaminKController,
                    dinnerVitaminB3Controller,
                    dinnerChlorideController,
                    dinnerPhosphorusController,
                    dinnerChromiumController,
                    dinnerCopperController,
                    dinnerFluorideController,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          print("Forwarding");
                          await nutriBase.addDay(
                            _selectedDate.value,
                            double.parse(breakfastCaloriesController.text),
                            double.parse(breakfastProteinController.text),
                            double.parse(breakfastSugarController.text),
                            double.parse(breakfastFatsController.text),
                            double.parse(breakfastFiberController.text),
                            double.parse(breakfastCalciumController.text),
                            double.parse(breakfastCarbsController.text),
                            double.parse(breakfastIronController.text),
                            double.parse(breakfastSaturatedFatsController.text),
                            double.parse(breakfastUnsaturatedFatsController.text),
                            double.parse(breakfastMagnesiumController.text),
                            double.parse(breakfastTransFatsController.text),
                            double.parse(breakfastPotassiumController.text),
                            double.parse(breakfastManganeseController.text),
                            double.parse(breakfastSeleniumController.text),
                            double.parse(breakfastSodiumController.text),
                            double.parse(breakfastZincController.text),
                            double.parse(breakfastIodineController.text),
                            double.parse(breakfastVitaminAController.text),
                            double.parse(breakfastVitaminB1Controller.text),
                            double.parse(breakfastVitaminB2Controller.text),
                            double.parse(breakfastVitaminB5Controller.text),
                            double.parse(breakfastVitaminB6Controller.text),
                            double.parse(breakfastVitaminB7Controller.text),
                            double.parse(breakfastVitaminB9Controller.text),
                            double.parse(breakfastVitaminB12Controller.text),
                            double.parse(breakfastVitaminCController.text),
                            double.parse(breakfastVitaminDController.text),
                            double.parse(breakfastVitaminEController.text),
                            double.parse(breakfastVitaminFController.text),
                            double.parse(breakfastVitaminKController.text),
                            double.parse(breakfastVitaminB3Controller.text),
                            double.parse(breakfastChlorideController.text),
                            double.parse(breakfastCopperController.text),
                            double.parse(breakfastChromiumController.text),
                            double.parse(breakfastPhosphorusController.text),
                            double.parse(breakfastFluorideController.text),
                            // lunch
                            double.parse(lunchCaloriesController.text),
                            double.parse(lunchProteinController.text),
                            double.parse(lunchSugarController.text),
                            double.parse(lunchFatsController.text),
                            double.parse(lunchFiberController.text),
                            double.parse(lunchCalciumController.text),
                            double.parse(lunchCarbsController.text),
                            double.parse(lunchIronController.text),
                            double.parse(lunchSaturatedFatsController.text),
                            double.parse(lunchUnsaturatedFatsController.text),
                            double.parse(lunchMagnesiumController.text),
                            double.parse(lunchTransFatsController.text),
                            double.parse(lunchPotassiumController.text),
                            double.parse(lunchManganeseController.text),
                            double.parse(lunchSeleniumController.text),
                            double.parse(lunchSodiumController.text),
                            double.parse(lunchZincController.text),
                            double.parse(lunchIodineController.text),
                            double.parse(lunchVitaminAController.text),
                            double.parse(lunchVitaminB1Controller.text),
                            double.parse(lunchVitaminB2Controller.text),
                            double.parse(lunchVitaminB5Controller.text),
                            double.parse(lunchVitaminB6Controller.text),
                            double.parse(lunchVitaminB7Controller.text),
                            double.parse(lunchVitaminB9Controller.text),
                            double.parse(lunchVitaminB12Controller.text),
                            double.parse(lunchVitaminCController.text),
                            double.parse(lunchVitaminDController.text),
                            double.parse(lunchVitaminEController.text),
                            double.parse(lunchVitaminFController.text),
                            double.parse(lunchVitaminKController.text),
                            double.parse(lunchVitaminB3Controller.text),
                            double.parse(lunchChlorideController.text),
                            double.parse(lunchCopperController.text),
                            double.parse(lunchChromiumController.text),
                            double.parse(lunchPhosphorusController.text),
                            double.parse(lunchFluorideController.text),
                            // dinner
                            double.parse(dinnerCaloriesController.text),
                            double.parse(dinnerProteinController.text),
                            double.parse(dinnerSugarController.text),
                            double.parse(dinnerFatsController.text),
                            double.parse(dinnerFiberController.text),
                            double.parse(dinnerCalciumController.text),
                            double.parse(dinnerCarbsController.text),
                            double.parse(dinnerIronController.text),
                            double.parse(dinnerSaturatedFatsController.text),
                            double.parse(dinnerUnsaturatedFatsController.text),
                            double.parse(dinnerMagnesiumController.text),
                            double.parse(dinnerTransFatsController.text),
                            double.parse(dinnerPotassiumController.text),
                            double.parse(dinnerManganeseController.text),
                            double.parse(dinnerSeleniumController.text),
                            double.parse(dinnerSodiumController.text),
                            double.parse(dinnerZincController.text),
                            double.parse(dinnerIodineController.text),
                            double.parse(dinnerVitaminAController.text),
                            double.parse(dinnerVitaminB1Controller.text),
                            double.parse(dinnerVitaminB2Controller.text),
                            double.parse(dinnerVitaminB5Controller.text),
                            double.parse(dinnerVitaminB6Controller.text),
                            double.parse(dinnerVitaminB7Controller.text),
                            double.parse(dinnerVitaminB9Controller.text),
                            double.parse(dinnerVitaminB12Controller.text),
                            double.parse(dinnerVitaminCController.text),
                            double.parse(dinnerVitaminDController.text),
                            double.parse(dinnerVitaminEController.text),
                            double.parse(dinnerVitaminFController.text),
                            double.parse(dinnerVitaminKController.text),
                            double.parse(dinnerVitaminB3Controller.text),
                            double.parse(dinnerChlorideController.text),
                            double.parse(dinnerCopperController.text),
                            double.parse(dinnerChromiumController.text),
                            double.parse(dinnerPhosphorusController.text),
                            double.parse(dinnerFluorideController.text),
                          );
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

  Widget sectionEntryArea(
      String title,
      TextEditingController food,
      TextEditingController ncalories,
      TextEditingController protein,
      TextEditingController sugar,
      TextEditingController fats,
      TextEditingController fiber,
      TextEditingController calcium,
      TextEditingController carbs,
      TextEditingController iron,
      TextEditingController saturatedFats,
      TextEditingController unsaturatedFats,
      TextEditingController magnesium,
      TextEditingController transFats,
      TextEditingController potassium,
      TextEditingController manganese,
      TextEditingController selenium,
      TextEditingController sodium,
      TextEditingController zinc,
      TextEditingController iodine,
      TextEditingController vitaminA,
      TextEditingController vitaminB1,
      TextEditingController vitaminB2,
      TextEditingController vitaminB5,
      TextEditingController vitaminB6,
      TextEditingController vitaminB7,
      TextEditingController vitaminB9,
      TextEditingController vitaminB12,
      TextEditingController vitaminC,
      TextEditingController vitaminD,
      TextEditingController vitaminE,
      TextEditingController vitaminF,
      TextEditingController vitaminK,
      // added later
      TextEditingController vitaminB3,
      TextEditingController chloride,
      TextEditingController phosphorus,
      TextEditingController chromium,
      TextEditingController copper,
      TextEditingController fluoride,
      )
  {
    return Container(
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
              title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 20,),
            inputBox("Food Consumed", food, "E.g. Biryani", false, false),
            SizedBox(height: 10,),
            inputBox("Calories", ncalories, "E.g. 120", false, true),
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
                  child: nutritionBox("Protein", "g", protein, "E.g. 5"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Carbs", "g", carbs, "E.g. 5"),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Fats", "g", fats, "E.g. 5"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Fiber", "g", fiber, "E.g. 5"),
                )
              ],
            ),
            SizedBox(height: 20,),
            Text(
              "Additional Nutrition",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 10,),
            // Row for Saturated Fats and Unsaturated Fats
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Saturated Fats", "g", saturatedFats, "E.g. 3"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Unsaturated Fats", "g", unsaturatedFats, "E.g. 7"),
                ),
              ],
            ),
            // Row for Magnesium and Trans Fats
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Sugar", "g", sugar, "E.g. 1"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("TransFats", "g", transFats, "E.g. 1"),
                ),
              ],
            ),
            // Row for Vitamin A and Vitamin B1
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminA", "µg", vitaminA, "E.g. 500"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("VitaminB1", "mg", vitaminB1, "E.g. 0.2"),
                ),
              ],
            ),

            // Row for V_B2 and V_B5
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminB2", "mg", vitaminB2, "E.g. 0.3"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("VitaminB3", "mg", vitaminB3, "E.g. 2"),
                ),
              ],
            ),

            // Row for V_B6 and V_B7
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminB5", "mg", vitaminB5, "E.g. 1"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("VitaminB6", "mg", vitaminB6, "E.g. 0.4"),
                ),
              ],
            ),

            // Row for V_B9 and V_B12
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminB7", "µg", vitaminB7, "E.g. 30"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("VitaminB9", "µg", vitaminB9, "E.g. 40"),
                ),
              ],
            ),

            // Row for V_C and V_D
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminB12", "µg", vitaminB12, "E.g. 2"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("VitaminC", "mg", vitaminC, "E.g. 30"),
                ),
              ],
            ),

            // Row for V_E and V_F
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminD", "µg", vitaminD, "E.g. 5"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("VitaminE", "mg", vitaminE, "E.g. 2"),
                ),
              ],
            ),
            // SizedBox(height: 5,),
            // Row for V_K
            Row(
              children: [
                Expanded(
                  child: nutritionBox("VitaminK", "µg", vitaminK, "E.g. 2"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Molybdenum", "µg", vitaminF, "E.g. 1"),
                ),
                // SizedBox(width: 20,), // Optional spacing between boxes
              ],
            ),
            // Row for Calcium and Iron
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Calcium", "mg", calcium, "E.g. 200"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Iron", "mg", iron, "E.g. 2"),
                ),
              ],
            ),
            // Row for Potassium and Manganese
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Potassium", "mg", potassium, "E.g. 300"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Manganese", "mg", manganese, "E.g. 0.5"),
                ),
              ],
            ),

            // Row for Selenium and Sodium
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Selenium", "µg", selenium, "E.g. 5"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Sodium", "mg", sodium, "E.g. 150"),
                ),
              ],
            ),

            // Row for Zinc and Iodine
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Zinc", "mg", zinc, "E.g. 2"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Iodine", "µg", iodine, "E.g. 50"),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Magnesium", "mg", magnesium, "E.g. 100"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Chloride", "mg", chloride, "E.g. 1"),
                ),
                // SizedBox(width: 20,), // Optional spacing between boxes
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Phosphorus", "mg", phosphorus, "E.g. 2"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Chromium", "µg", chromium, "E.g. 1"),
                ),
                // SizedBox(width: 20,), // Optional spacing between boxes
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: nutritionBox("Copper", "mg", copper, "E.g. 2"),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: nutritionBox("Fluoride", "mg", fluoride, "E.g. 1"),
                ),
                // SizedBox(width: 20,), // Optional spacing between boxes
              ],
            ),
          ],
        )
    );
  }

  nutritionBox(String title, String units, TextEditingController tempController, String hintText) {
    return Row(
      children: [
        Expanded(child: Text(title, style: TextStyle(fontSize: 8, color: Color(0xff454B60)),)),
        SizedBox(width: 5,),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
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
            style: TextStyle(fontSize: 8, color: Color(0xff454B60)),
            decoration: new InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 8, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(width: 5,),
        SizedBox(
          width: 20,
            child: Text(units, style: TextStyle(fontSize: 8, color: Color(0xff454B60)),)
        ),
      ],
    );
  }
}