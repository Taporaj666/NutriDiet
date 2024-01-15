import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutridiet/BusinessLogic/ImageHelper.dart';
import 'package:nutridiet/BusinessLogic/utils.dart';
import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image/image.dart' as IMG;
import 'package:nutridiet/Home/SubPages/SubHome.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  final imageHelper = ImageHelper();
  late ImageLabeler _imageLabeler;
  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  
  File? _image;

  String title = "---";
  String calories = "---";
  String description = "---";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeLabeler();
  }

  @override
  void dispose() {
    _canProcess = false;
    _imageLabeler.close();
    super.dispose();
  }

  biasGenerator(double bias) {
    return (userBMR * bias).toStringAsFixed(1);
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
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
                    " Food Planning",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              textRow("Daily Calory Goals", "", 24),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              textRow("Light Exercise:", biasGenerator(1.2), 16),
              SizedBox(height: 10,),
              textRow("Medium Exercise:", biasGenerator(1.55), 16),
              SizedBox(height: 10,),
              textRow("Hard Exercise:", biasGenerator(1.725), 16),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              recommendedSection(),
              SizedBox(height: 20,),
              Divider(),
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
                      randomCalories();
                    }
                  }
                },
                child: containerCustom(),
              ),
              SizedBox(height: 20,),
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Calories: $calories",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                      Spacer(),
                    ],
                  )
              ),
            ],
          )
        ),
      ),
    );
  }

  recommendedSection() {

    String recommendation = "";
    String foodName = "";
    String foodCal = "";
    String foodUrl = "";

    if (userGoal ==  "Gain") {
      recommendation = "Low Calories";
      foodName = "Salad";
      foodCal = "70";
      foodUrl = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fminimalistbaker.com%2Fwp-content%2Fuploads%2F2014%2F12%2FSIMPLE-satisfying-Spinach-Salad-with-Roasted-Pumpkin-Seeds-and-tons-of-veggies-vegan-glutenfree.jpg&f=1&nofb=1&ipt=ceb0d43a5f629df81be41ee91198f056da01c1ad72ce6cfb7cf67baa9f700f8f&ipo=images";
    }
    else if (userGoal ==  "Maintain") {
      recommendation = "Moderate Calories";
      foodName = "Butter Fish";
      foodCal = "120";
      foodUrl = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.mashed.com%2Fimg%2Fgallery%2Ffish-dishes-so-good-youll-want-to-make-them-every-day%2Fl-intro-1614696518.jpg&f=1&nofb=1&ipt=677cf32f0978347f547e36fd93aa5929766f5eacdb830a3679e60c32b1a2e05f&ipo=images";
    }
    else if (userGoal ==  "Lose") {
      recommendation = "High Calories";
      foodName = "Beef Roast";
      foodCal = "200";
      foodUrl = "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.cheap-chef.com%2Fwp-content%2Fuploads%2F2019%2F04%2FIMG_2089.jpg&f=1&nofb=1&ipt=d1661bd3ee934a7b54c175f664546066ae6552d58a3ed83ec12e6de58d287efa&ipo=images";
    }

    return Column(
      children: [
        textRow("Recommendation: ", recommendation, 18),
        SizedBox(height: 20,),
        foodItem(foodName, foodCal, foodUrl),
      ],
    );
  }

  foodItem(String name, String calories, String imageUrl) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.all(15),
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
                Text(name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color(0xff3D4048),
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(calories,
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
            child: Image.network(imageUrl,
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
    );
  }

  containerCustom() {
    return _image != null ? Container(
        height: 250,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_image!), fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
    ) : Container(
        height: 250,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            Spacer(),
            Icon(Icons.camera_alt_outlined),
            Text(
              "Scan to get calories of food",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300
              ),
            ),
            Spacer(),
          ],
        )
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