class Medicine {
  String? id;
  String? imageUrl;
  String? name;
  String? noTimes;
  String? time1;
  String? time2;
  String? time3;
  double? pill1;
  double? pill2;
  double? pill3;
  String? schedule;
  bool? isReminderOpen;
  DateTime? createdAt;

  Medicine({
    this.id,
    this.imageUrl,
    this.name,
    this.noTimes,
    this.time1,
    this.time2,
    this.time3,
    this.pill1,
    this.pill2,
    this.pill3,
    this.schedule,
    this.isReminderOpen = false,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['noTimes'] = noTimes;
    data['time1'] = time1;
    data['time2'] = time2;
    data['time3'] = time3;
    data['pill1'] = pill1;
    data['pill2'] = pill2;
    data['pill3'] = pill3;
    data['schedule'] = schedule;
    data['createdAt'] = createdAt;
    data['isReminderOpen'] = isReminderOpen;
    return data;
  }

  Medicine.fromJson(json, this.id) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    noTimes = json['noTimes'];
    time1 = json['time1'];
    time2 = json['time2'];
    time3 = json['time3'];
    pill1 = json['pill1'];
    pill2 = json['pill2'];
    pill3 = json['pill3'];
    schedule = json['schedule'];
    isReminderOpen = json['isReminderOpen'] ?? false;
    createdAt = json['createdAt'].toDate();
  }
}
