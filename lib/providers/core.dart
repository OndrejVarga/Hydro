import 'package:Hydro/screens/main_screen.dart';
import 'package:Hydro/utils/database.dart';
import 'package:Hydro/utils/days_data_model.dart';
import 'package:Hydro/utils/presets_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locally/locally.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Core with ChangeNotifier {
  bool _hasInnit = false;
  Locally _locally;

  /*Presets settings*/
  PresetsModel _presets = PresetsModel(
      goal: 1000,
      cupSize: 100,
      localySavedDays: 31,
      notification: false,
      serverData: false,
      alarm: false);

  /* Todays day*/
  DaysDataModel _day = DaysDataModel(
      day: DateTime.now().day,
      year: DateTime.now().year,
      month: DateTime.now().month,
      currentGoal: 100,
      progress: []);

  DateTime get currentDate => DateTime(_day.year, _day.month, _day.day);
  String get currentDateFormmated =>
      DateFormat.yMMMd().format(DateTime(_day.year, _day.month, _day.day));
  PresetsModel get presets => _presets;
  int get amountOfDrunkWater => _day.amountOfDrunkWater;
  bool get hasInnit => _hasInnit;
  Locally get locally => _locally;

  int get pctOfGoal =>
      ((_day.amountOfDrunkWater / _presets.currentPresets['goal']) * 100)
          .toInt();

  void changeCurrentDate(DateTime date) async {
    _day = await DBProvider.db.getDaysEntry(date);
    if (_day == null) {
      _day = DaysDataModel(
          year: date.year,
          month: date.month,
          day: date.day,
          currentGoal: _presets.currentPresets['goal'],
          progress: []);
    }
    notifyListeners();
  }

  void changeHasInnit() {
    _hasInnit = true;
  }

  void addDrink() {
    if (_day.day == DateTime.now().day &&
        _day.month == DateTime.now().month &&
        _day.year == DateTime.now().year) {
      _day.addToProgress(presets.currentPresets['cupSize'], DateTime.now().hour,
          DateTime.now().minute);
      print(_day.toMap());
      DBProvider.db.newDaysEntry(_day);
    }
    notifyListeners();
  }

  void removeDataFromTimeScale() async {
    DateTime limit =
        DateTime.now().subtract(Duration(days: presets.localySavedDays));
    List<DaysDataModel> allData = await DBProvider.db.getAllData(3, null);
    for (int i = 0; i < allData.length; i++) {
      DateTime newDateTime =
          DateTime(allData[i].year, allData[i].month, allData[i].day);
      if (newDateTime.isBefore(limit)) {
        DBProvider.db.removeData(newDateTime);
      }
    }
  }

  void updateDataFromServer(PresetsModel presets, DaysDataModel day) {
    _presets = presets;
    _day = day;
    _day.currentGoal = _presets.goal;
    notifyListeners();
  }

  void updatePresetsFromData(
      PresetsModel presets, DaysDataModel daysDataModel) {
    print(presets.currentPresets);
    _presets = presets;
    _day.currentGoal = _presets.goal;
    _day = daysDataModel;
  }

  void changePreferences(Map<String, dynamic> newPresets) {
    _presets = PresetsModel(
        goal: newPresets['goal'] > 0
            ? newPresets['goal']
            : _presets.currentPresets['goal'],
        cupSize: newPresets['cupSize'] > 0
            ? newPresets['cupSize']
            : _presets.currentPresets['cupSize'],
        localySavedDays: newPresets['localySavedDays'],
        notification: newPresets['notification'],
        serverData: newPresets['serverData'],
        alarm: newPresets['alarm']);
    DBProvider.db.updatePresets(_presets);

    if (_day.day == DateTime.now().day &&
        _day.month == DateTime.now().month &&
        _day.year == DateTime.now().year) {
      _day.currentGoal = _presets.goal;
    }
  }

  void innitNotification(BuildContext context) {
    _locally = Locally(
      context: context,
      payload: 'Notification',
      pageRoute: MaterialPageRoute(
          builder: (context) => MainScreen(
                toRestart: true,
              )),
      appIcon: 'drawable/app_icon',
    );
    locally.showPeriodically(
        title: "Hi! It's your water reminder",
        message: 'Now is the time to drink a glass of water',
        repeatInterval: RepeatInterval.hourly);
  }
}
