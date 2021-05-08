import 'package:Hydro/providers/core.dart';
import 'package:Hydro/screens/data_screen.dart';
import 'package:Hydro/screens/presets_screen.dart';
import 'package:Hydro/screens/water_screen.dart';
import 'package:Hydro/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final bool toRestart;
  @override
  _MainScreenState createState() => _MainScreenState();
  MainScreen({this.toRestart = false});
}

class _MainScreenState extends State<MainScreen> {
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 1,
    );
    if (widget.toRestart) {
      FlutterRestart.restartApp();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBProvider.db.getData(context),
      builder: (context, snaphot) {
        if (snaphot.hasData) {
          if (!Provider.of<Core>(context, listen: false).hasInnit) {
            Provider.of<Core>(context).updatePresetsFromData(
                snaphot.data['Presets'], snaphot.data['Day']);
            Provider.of<Core>(context, listen: false).changeHasInnit();
          }
          if (Provider.of<Core>(context, listen: false).presets.notification) {
            Provider.of<Core>(context, listen: false)
                .innitNotification(context);
          }

          return PageView(
            controller: _controller,
            children: [
              Presets(),
              WaterScreen(),
              DataScreen(),
            ],
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
