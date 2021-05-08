class Progress {
    Progress({
        this.cupSize,
        this.hour,
        this.minute,
    });

    int cupSize;
    int hour;
    int minute;

    factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        cupSize: json["cupSize"],
        hour: json["hour"],
        minute: json["minute"],
    );

    Map<String, dynamic> toJson() => {
        "cupSize": cupSize,
        "hour": hour,
        "minute": minute,
    };
}