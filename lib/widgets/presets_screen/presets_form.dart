import 'package:Hydro/providers/core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class PresetsForm extends StatefulWidget {
  @override
  _PresetsFormState createState() => _PresetsFormState();
  final GlobalKey<FormState> _formKey;
  PresetsForm(this._formKey);
}

class _PresetsFormState extends State<PresetsForm> {
  Map<String, dynamic> currentPresets;

  @override
  void didChangeDependencies() {
    currentPresets = Provider.of<Core>(context).presets.currentPresets;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: widget._formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goal',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: 130,
                      height: 40,
                      child: TextFormField(
                        initialValue: Provider.of<Core>(context)
                            .presets
                            .currentPresets['goal']
                            .toString(),
                        onChanged: (val) {
                          if (int.tryParse(val) != null) {
                            currentPresets['goal'] = int.tryParse(val);
                          }
                        },
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontSize: 20),
                        key: const ValueKey('goal'),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: HexColor('#515756'), width: 1),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cup Size',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: 130,
                      height: 40,
                      child: TextFormField(
                        initialValue: Provider.of<Core>(context)
                            .presets
                            .currentPresets['cupSize']
                            .toString(),
                        onSaved: (val) {
                          print(currentPresets);
                          Provider.of<Core>(context, listen: false)
                              .changePreferences(currentPresets);
                        },
                        onChanged: (val) {
                          if (int.tryParse(val) != null) {
                            currentPresets['cupSize'] = int.parse(val);
                          }
                        },
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontSize: 20),
                        key: const ValueKey('Cupsize'),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: 7, color: Colors.red),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: HexColor('#515756'), width: 1),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 3),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notifications',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 20),
                    ),
                    Container(
                      child: Theme(
                        data: ThemeData(
                            unselectedWidgetColor:
                                Theme.of(context).accentColor),
                        child: Checkbox(
                          onChanged: (val) {
                            setState(() {
                              if (!val) {
                                Provider.of<Core>(context, listen: false)
                                    .locally
                                    .cancelAll();
                              } else {
                                Provider.of<Core>(context, listen: false)
                                    .innitNotification(context);
                              }
                              currentPresets['notification'] = val;
                            });
                          },
                          key: const ValueKey('notification'),
                          value: currentPresets['notification'],
                          activeColor: Theme.of(context).accentColor,
                          checkColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Days saved localy',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Theme.of(context).accentColor,
                          inactiveTrackColor:
                              Theme.of(context).accentColor.withAlpha(80),
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 4.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          thumbColor: Theme.of(context).accentColor,
                          overlayColor: Theme.of(context).accentColor,
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 10.0),
                          tickMarkShape: RoundSliderTickMarkShape(),
                          activeTickMarkColor: Theme.of(context).accentColor,
                          inactiveTickMarkColor:
                              Theme.of(context).accentColor.withAlpha(0),
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Theme.of(context).accentColor,
                          valueIndicatorTextStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        child: Slider(
                          divisions: 30,
                          value: currentPresets['localySavedDays'].toDouble(),
                          onChanged: (val) {
                            setState(() {
                              currentPresets['localySavedDays'] = val.toInt();
                            });
                          },
                          max: 31,
                          min: 1,
                          label: currentPresets['localySavedDays'] == 31
                              ? 'All'
                              : currentPresets['localySavedDays'].toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
