import 'package:Hydro/utils/days_data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WaterLineChart extends StatefulWidget {
  final List<DaysDataModel> data;
  WaterLineChart(this.data);
  @override
  _WaterLineChartState createState() => _WaterLineChartState();
}

class _WaterLineChartState extends State<WaterLineChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    print(widget.data[0].day);
    print(widget.data[0].month);
    print(widget.data[0].year);
    print(widget.data[0].currentGoal);
    print(widget.data[0].amountOfDrunkWater);
    print(widget.data.length);
    if (widget.data.length == 1 && widget.data[0].amountOfDrunkWater == 0) {
      return null;
    }
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child:
                  LineChart(widget.data.length > 1 ? mainData() : oneDayData()),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 10),
            getTitles: (value) {
              print(value);
              print(widget.data.length);
              if (value != 0 &&
                  widget.data[((widget.data.length) - (value)).toInt()]
                          .amountOfDrunkWater >
                      0) {
                return widget.data[((widget.data.length) - (value)).toInt()].day
                        .toString() +
                    '/' +
                    widget.data[((widget.data.length) - (value)).toInt()].month
                        .toString();
              }
            }),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 0)),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: fromDataToGraphPoints(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> fromDataToGraphPoints() {
    List<FlSpot> spots = [];
    for (int i = widget.data.length - 1; i >= 0; i--) {
      print(widget.data[i].day.toString() +
          ' ' +
          widget.data[i].month.toString() +
          ' ' +
          widget.data[i].year.toString());
      spots.add(FlSpot((i - widget.data.length).abs().toDouble(),
          widget.data[i].amountOfDrunkWater.toDouble()));
    }
    return spots;
  }

  LineChartData oneDayData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 10),
            getTitles: (value) {
              print(value);
              return widget.data[0].progress[value.toInt()].hour.toString() +
                  ':' +
                  widget.data[0].progress[value.toInt()].minute.toString();
            }),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 0)),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: fromProgressToPoints(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  List<FlSpot> fromProgressToPoints() {
    List<FlSpot> spots = [];
    double count = 0;
    for (int i = 0; i < widget.data[0].progress.length; i++) {
      print('val');
      print(i);
      print('val');
      count += widget.data[0].progress[i].cupSize.toDouble();
      spots.add(FlSpot((i).toDouble(), count));
    }

    return spots;
  }
}
