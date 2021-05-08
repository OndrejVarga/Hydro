import 'package:Hydro/widgets/water_screen/circular_indicator.dart';
import 'package:flutter/material.dart';

class WaterCounter extends StatefulWidget {
  @override
  _WaterCounterState createState() => _WaterCounterState();
}

class _WaterCounterState extends State<WaterCounter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(height:50),
        Container(
          child: CircIndiCator()
        ),

      ],
    );
  }
}
