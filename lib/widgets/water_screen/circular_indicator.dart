import 'package:Hydro/providers/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircIndiCator extends StatefulWidget {
  @override
  _CircIndiCatorState createState() => _CircIndiCatorState();
}

class _CircIndiCatorState extends State<CircIndiCator> {
  @override
  Widget build(BuildContext context) {
    final CircularSliderAppearance appearance02 = CircularSliderAppearance(
      customWidths: CustomSliderWidths(
          progressBarWidth: 20, trackWidth: 0, handlerSize: 0),
      customColors: CustomSliderColors(
          trackColor: Theme.of(context).backgroundColor,
          progressBarColor: Theme.of(context).accentColor,
          hideShadow: true),
      infoProperties: InfoProperties(
        bottomLabelText: "${Provider.of<Core>(context).amountOfDrunkWater} ml / ${Provider.of<Core>(context).presets.currentPresets['goal']} ml",
        bottomLabelStyle: Theme.of(context).textTheme.headline2.copyWith(
          height: 2,
          fontSize: 20
        ),
        mainLabelStyle: Theme.of(context).textTheme.headline3.copyWith(
              fontSize: 40.0,
            ),
            modifier: (double value){
              return '${value.toInt().toString()} %';
            }
      ),
      startAngle: 270,
      angleRange: 360,
      size: 250.0,
      animationEnabled: true,
    );

    return Center(
        child: SleekCircularSlider(
      appearance: appearance02,
      min: 0,
      max: 100,
      initialValue: Provider.of<Core>(context).pctOfGoal.toDouble() >= 100 ? 100:Provider.of<Core>(context).pctOfGoal.toDouble() ,
    ));
  }
}
