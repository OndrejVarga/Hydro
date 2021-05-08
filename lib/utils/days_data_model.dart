import 'package:Hydro/utils/progress_model.dart';

class DaysDataModel {
  int year, month, day;
  DateTime dateTime;
  int currentGoal;
  List<Progress> progress;

  DaysDataModel(
      {this.year, this.month, this.day, this.currentGoal, this.progress});

  int get amountOfDrunkWater {
    int amount = 0;

    for (int i = 0; i < progress.length; i++) {
      amount += progress[i].cupSize;
    }

    return amount;
  }

  void addToProgress(int cupSize, int hour, int minute) {
    progress.add(Progress(cupSize: cupSize, hour: hour, minute: minute));
  }

  factory DaysDataModel.fromMap(Map<String, dynamic> json) => new DaysDataModel(
          year: json["year"],
          month: json["month"],
          day: json["day"],
          currentGoal: json["current_goal"],
          progress: [
            Progress.fromJson({
              "cupSize": json["cupSize"],
              "hour": json['hour'],
              "minute": json['minute'],
            })
          ]);

  Map<String, dynamic> toMap() => {
        "year": year,
        "month": month,
        "day": day,
        "hour": progress.last.toJson()['hour'],
        "minute": progress.last.toJson()['minute'],
        "currentGoal": currentGoal,
        "cupSize": progress.last.toJson()['cupSize']
      };
}
