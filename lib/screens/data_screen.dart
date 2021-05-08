import 'package:Hydro/utils/database.dart';
import 'package:Hydro/widgets/data_report_screen/data_widget.dart';
import 'package:Hydro/widgets/data_report_screen/lineChart.dart';
import 'package:Hydro/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  int currentTimeFrame = 3;
  //0-Day
  //1-Week
  //2-Month
  //3-All
  //4-Specific date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: DBProvider.db.getAllData(currentTimeFrame, context),
              builder: (ctx, snapshot) {
                if (snapshot.hasData)
                  return Column(
                    children: [
                      TopBar('Data ', 'report'),
                      DataReportField(
                        DataTextRow('Total amount',
                            DBProvider.totalAmout.toString(), 'ml'),
                      ),

                      //Buttons-------------------------------------------------
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentTimeFrame = 0;
                                });
                              },
                              child: CircularTimeFrameSelector(
                                  '1D', 0, currentTimeFrame),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentTimeFrame = 1;
                                });
                              },
                              child: CircularTimeFrameSelector(
                                  '7D', 1, currentTimeFrame),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentTimeFrame = 2;
                                });
                              },
                              child: CircularTimeFrameSelector(
                                  '30D', 2, currentTimeFrame),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentTimeFrame = 3;
                                });
                              },
                              child: CircularTimeFrameSelector(
                                  'ALL', 3, currentTimeFrame),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentTimeFrame = 4;
                                });
                              },
                              child: CircularTimeFrameSelector(
                                  'DATE', 4, currentTimeFrame),
                            )
                          ],
                        ),
                      ),
                      if (snapshot.data.length > 0)
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: WaterLineChart(snapshot.data)),

                      DataReportField(Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DataTextRow('Goal reached',
                                DBProvider.goalReached.toString(), 'x'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DataTextRow('Avg. amount',
                                DBProvider.averageAmount.toString(), 'ml'),
                          ),
                          DataTextRow('Succes Rate',
                              DBProvider.successRate.toString(), '%'),
                        ],
                      )),
                    ],
                  );
                else {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(child: CircularProgressIndicator()));
                }
              }),
        ),
      ),
    );
  }
}

class CircularTimeFrameSelector extends StatelessWidget {
  final String text;
  final int id;
  final int currentTimeFrame;
  CircularTimeFrameSelector(this.text, this.id, this.currentTimeFrame);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentTimeFrame == id
            ? Theme.of(context).accentColor
            : Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(color: Colors.white, fontSize: 15),
      ),
    );
  }
}

class DataTextRow extends StatelessWidget {
  final String text;
  final String data;
  final String unit;

  const DataTextRow(this.text, this.data, this.unit);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 20),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              data + ' ' + unit,
              style:
                  Theme.of(context).textTheme.headline2.copyWith(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
