import 'package:Hydro/providers/core.dart';
import 'package:Hydro/widgets/water_screen/water_top_bar.dart';
import 'package:Hydro/widgets/water_screen/water_counter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Drawer(),
      body: Container(
        child: Column(
          children: [
            TopBar(_scaffoldKey),
            WaterCounter(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime curr = Provider.of<Core>(context, listen: false).currentDate;
          if (curr.day == DateTime.now().day &&
              curr.month == DateTime.now().month &&
              curr.year == DateTime.now().year) {
            Provider.of<Core>(context, listen: false).addDrink();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
