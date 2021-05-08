import 'package:Hydro/providers/core.dart';
import 'package:Hydro/widgets/presets_screen/presets_form.dart';
import 'package:Hydro/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Presets extends StatefulWidget {
  static const String routeId = 'presets';
  @override
  _PresetsState createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [TopBar('Choose ', 'presets'), PresetsForm(_formKey)],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 10),
          child: FloatingActionButton.extended(
            label: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'SAVE',
                style: TextStyle(fontSize: 10),
              ),
            ),
            onPressed: () async {
              _formKey.currentState.save();
              if (Provider.of<Core>(context, listen: false)
                      .presets
                      .localySavedDays !=
                  31) {
                Provider.of<Core>(context, listen: false)
                    .removeDataFromTimeScale();
              }
            },
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat);
  }
}
