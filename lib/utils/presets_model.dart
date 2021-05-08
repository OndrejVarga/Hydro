import 'dart:convert';

class PresetsModel {
  int goal, cupSize, localySavedDays;
  bool notification, serverData, alarm;

  PresetsModel({
    this.goal,
    this.cupSize,
    this.localySavedDays,
    this.notification,
    this.serverData,
    this.alarm,
  });

  Map<String, dynamic> get currentPresets {
    return {
      'goal': goal,
      'cupSize': cupSize,
      'localySavedDays': localySavedDays,
      'notification': notification,
      'serverData': serverData,
      'alarm': alarm,
    };
  }

  factory PresetsModel.fromMap(Map<String, dynamic> json) => new PresetsModel(
        goal: json["goal"],
        cupSize: json["cup_size"],
        notification: json["notification"] == 1 ? true : false,
        serverData: json["server_data"]== 1 ? true : false,
        alarm: json["alarm"]== 1 ? true : false,
        localySavedDays: json["days_saved_localy"],
      );
  Map<String, dynamic> toMap() => {
        'goal': goal,
        'cup_Size': cupSize,
        'days_saved_localy': localySavedDays,
        'notification': notification == true ? 1 : 0,
        'server_data': serverData == true ? 1 : 0,
        'alarm': alarm== true ? 1 : 0,
      };
}

PresetsModel clientFromJson(String str) {
  final jsonData = json.decode(str);
  return PresetsModel.fromMap(jsonData);
}

String clientToJson(PresetsModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
