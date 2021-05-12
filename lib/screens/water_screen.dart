import 'dart:io';

import 'package:Hydro/providers/core.dart';
import 'package:Hydro/screens/aboutapp_screen.dart';
import 'package:Hydro/widgets/water_screen/water_top_bar.dart';
import 'package:Hydro/widgets/water_screen/water_counter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  final PageController _controller;
  WaterScreen(this._controller);
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
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.height * (1 / 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Hydro",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              DrawerButton('Presets', () {
                widget._controller.animateToPage(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              }),
              DrawerButton('Data', () {
                widget._controller.animateToPage(3,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              }),
              DrawerButton('About App', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutAppScreen()));
              }),
              DrawerButton('Exit', () {
                exit(0);
              })
            ],
          ),
        ),
      ),
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

class DrawerButton extends StatelessWidget {
  final String text;
  final Function function;
  DrawerButton(this.text, this.function);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: TextButton(
        child: Row(
          children: [
            Text(
              text,
              style:
                  Theme.of(context).textTheme.headline2.copyWith(fontSize: 25),
            ),
          ],
        ),
        onPressed: function,
      ),
    );
  }
}
