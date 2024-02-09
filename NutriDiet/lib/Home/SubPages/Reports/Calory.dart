import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {

  @override
  void initState() {
    loadCalories();
    super.initState();
  }

  double maxCal = 0;

  List<_ChartData> caloriesData = List.generate(30, (index) => _ChartData(index.toDouble(), 0));
  double netTotalCalories = 0;

  void loadCalories() async {
    caloriesData = [];
    var rawData = await FirebaseFirestore.instance.collection('intake').orderBy("date", descending: false).limit(30).get();
    print(rawData.size);

    for (int i = 0; i < 30; i++) {
      DateTime today = DateTime.now().subtract(Duration(days: i));
      double totalCalories = 0;

      for (int j = 0; j < rawData.size; j++) {
        if (rawData.docs[j].data()['date'].toDate().day == today.day &&
            rawData.docs[j].data()['date'].toDate().month == today.month &&
            rawData.docs[j].data()['date'].toDate().year == today.year) {
          totalCalories += rawData.docs[j].data()['breakfast_calories'] + rawData.docs[j].data()['lunch_calories'] + rawData.docs[j].data()['dinner_calories'];
          netTotalCalories += totalCalories;
          if (totalCalories > maxCal) {
            maxCal = totalCalories;
          }
        }
      }

      caloriesData.add(_ChartData(i.toDouble(), totalCalories));
    }

    // Fill the remaining entries with 0 if no data is available
    for (int i = caloriesData.length; i < 30; i++) {
      caloriesData.add(_ChartData(i.toDouble(), 0));
    }

    // Assuming that this function is part of a StatefulWidget, use setState to trigger a UI update.
    setState(() {
      print("Calories data updated");
    });
  }

  @override
  void dispose() {
    caloriesData!.clear();
    super.dispose();
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
                      " Calory Tracker",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Container(
                  height: 300,
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: buildSalesChart(),
                    key: ValueKey(1),
                  ),
                ),
                SizedBox(height: 50,),
                textRow("Total Calories:", netTotalCalories.toString(), 24),
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

  SfCartesianChart buildSalesChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Calories Consumed over 30 Days'),
      legend: Legend(
          isVisible: false,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: const NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          minimum: 0,
          maximum: 29,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: maxCal,
          labelFormat: '{value}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getSalesLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getSalesLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: caloriesData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          // width: 2,
          name: 'Calories',
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y,);
  final double x;
  final double y;
}