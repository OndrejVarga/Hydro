import 'package:Hydro/utils/progress_model.dart';
import 'package:Hydro/utils/days_data_model.dart';
import 'package:Hydro/utils/presets_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;
  static int totalAmout = 0;
  static int goalReached = 0;
  static int averageAmount = 0;
  static int successRate = 0;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "Hydro.db"),
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Presets("
            "goal INTEGER,"
            "cup_size INTEGER,"
            "notification INTEGER,"
            "server_data INTEGER,"
            "alarm INTEGER,"
            "days_saved_localy INTEGER);");
        return db.execute("CREATE TABLE Days("
            "year INTEGER,"
            "month INTEGER,"
            "day INTEGER,"
            "hour INTEGER,"
            "minute INTEGER,"
            "currentGoal INTEGER,"
            "cupSize INTEGER);");
      },
    );
  }

  Future<PresetsModel> getPresets() async {
    final db = await database;
    var res = await db.query("Presets");
    if (res.length == 0) {
      newPresets();
      return getPresets();
    }
    return PresetsModel.fromMap(res[0]);
  }

  updatePresets(PresetsModel presets) async {
    final db = await database;
    var res = await db.update("Presets", presets.toMap());
    return res;
  }

  newPresets() async {
    final db = await database;
    var res = await db.insert("Presets", {
      'goal': 1000,
      'cup_size': 100,
      'days_saved_localy': 31,
      'notification': 0,
      'server_data': 0,
      'alarm': 0,
    });
    return res;
  }

  newDaysEntry(DaysDataModel day) async {
    final db = await database;
    var res = await db.insert("Days", day.toMap());
    return res;
  }

  Future<DaysDataModel> getDaysEntry(DateTime date) async {
    List<Progress> progress = [];
    DaysDataModel dayModel = DaysDataModel(
        year: date.year,
        month: date.month,
        day: date.day,
        currentGoal: 0,
        progress: []);
    final db = await database;
    var res = await db.query("Days",
        where: "year = ? and month = ? and day = ?",
        whereArgs: [date.year, date.month, date.day]);
    for (int i = 0; i < res.length; i++) {
      print(Progress.fromJson(res[i]).toJson());
      progress.add(Progress.fromJson(res[i]));
      dayModel = DaysDataModel(
          year: res[i]['year'],
          month: res[i]['month'],
          day: res[i]['day'],
          currentGoal: res[i]['currentGoal'],
          progress: progress);
    }
    return dayModel;
  }

  Future<List<DaysDataModel>> getAllData(
      int timeFrame, BuildContext context) async {
    List<DaysDataModel> allData;

    final db = await database;
    var res = await db.query(
      'Days',
    );
    allData = await fromDBtoDaysDataModel(res);

    if (allData.length == 0) {
      return [];
    }
    List<Widget> listViewWidgets = [];
    allData.forEach(
      (element) {
        listViewWidgets.add(
          GestureDetector(
            onTap: () {
              return [element.day, element.month, element.year];
            },
            child: Container(
              child: Text(element.day.toString() +
                  ' ' +
                  element.month.toString() +
                  ' ' +
                  element.year.toString()),
            ),
          ),
        );
      },
    );

    switch (timeFrame) {
      case 0:
        DaysDataModel data = await getDaysEntry(DateTime.now());
        if (data != null) allData = [data];
        break;
      case 1:
        allData = [];
        for (int i = 0; i < 7; i++) {
          DaysDataModel data =
              await getDaysEntry(DateTime.now().subtract(Duration(days: i)));
          if (data != null) {
            allData.add(data);
          }
        }
        break;
      case 2:
        allData = [];
        for (int i = 0; i < 30; i++) {
          DaysDataModel data =
              await getDaysEntry(DateTime.now().subtract(Duration(days: i)));
          if (data != null) allData.add(data);
        }
        break;
      case 3:
        final db = await database;
        var res = await db.query('Days');
        allData = await fromDBtoDaysDataModel(res);
        allData = allData.reversed.toList();
        break;
      case 4:
        int indexA = 0;
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Dates',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.white, fontSize: 15),
              ),
              content: Container(
                height: 200.0,
                width: 400.0,
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor),
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: allData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        allData[index].day.toString() +
                            ' / ' +
                            allData[index].month.toString() +
                            ' / ' +
                            allData[index].year.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.white, fontSize: 15),
                      ),
                      onTap: () {
                        indexA = index;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );

        allData = [
          await getDaysEntry(DateTime(
              allData[indexA].year, allData[indexA].month, allData[indexA].day))
        ];
        break;
    }
    processData(allData);
    return allData;
  }

  void processData(List<DaysDataModel> data) {
    totalAmout = 0;
    goalReached = 0;
    averageAmount = 0;
    for (int i = 0; i < data.length; i++) {
      totalAmout += data[i].amountOfDrunkWater;
      (data[i].amountOfDrunkWater >= data[i].currentGoal) &&
              data[i].amountOfDrunkWater > 0
          ? goalReached++
          : null;
      averageAmount += data[i].amountOfDrunkWater;
    }
    averageAmount = averageAmount.toDouble() ~/ data.length;
    successRate = ((goalReached / data.length) * 100).toInt();
  }

  Future<Map<String, dynamic>> getData(BuildContext context) async {
    PresetsModel presets = await getPresets();
    DaysDataModel day = await getDaysEntry(DateTime.now());
    return {'Presets': presets, 'Day': day};
  }

  Future<List<DaysDataModel>> fromDBtoDaysDataModel(
      List<Map<String, dynamic>> query) async {
    List<DaysDataModel> allData = [];
    for (int i = 0; i < query.length; i++) {
      bool isOk = true;
      for (int j = 0; j < allData.length; j++) {
        if (query[i]['year'] == allData[j].year &&
            query[i]['month'] == allData[j].month &&
            query[i]['day'] == allData[j].day) {
          isOk = false;
          j = allData.length;
        }
      }
      if (isOk)
        allData.add(await getDaysEntry(
            DateTime(query[i]['year'], query[i]['month'], query[i]['day'])));
    }
    return allData;
  }

  void removeData(DateTime date) async {
    final db = await database;
    db.delete('Days',
        where: "year = ? and month = ? and day = ?",
        whereArgs: [date.year, date.month, date.day]);
  }
}
