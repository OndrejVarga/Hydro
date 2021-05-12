import 'package:Hydro/providers/core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  TopBar(this._scaffoldKey);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String title = 'TODAY';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              widget._scaffoldKey.currentState.openDrawer();
            },
            padding: const EdgeInsets.only(left: 10)),
        const Spacer(),
        Container(
          padding:
              const EdgeInsets.only(top: 30, right: 30, left: 0, bottom: 30),
          child: Padding(
            padding: EdgeInsets.zero,
            child: TextButton(
              onPressed: () async {
                DateTime date = await showDatePicker(
                  context: context,
                  initialDate:
                      Provider.of<Core>(context, listen: false).currentDate,
                  firstDate: DateTime(DateTime.now().year, 1, 1),
                  lastDate: DateTime(DateTime.now().year, 12, 30),
                  builder: (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                          primaryColor: Theme.of(context).primaryColor,
                          accentColor: Theme.of(context).accentColor,
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary)),
                      child: child,
                    );
                  },
                );

                setState(
                  () {
                    if (date != null) {
                      Provider.of<Core>(context, listen: false)
                          .changeCurrentDate(date);
                      if (date.day == DateTime.now().day &&
                          date.month == DateTime.now().month &&
                          date.year == DateTime.now().year) {
                        title = "TODAY";
                      } else {
                        title = Provider.of<Core>(context, listen: false)
                            .currentDateFormmated;
                      }
                    }
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          child: Text(""),
        )
      ],
    );
  }
}
