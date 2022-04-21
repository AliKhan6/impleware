class Setting {
  String? id;
  bool? isNoti;
  String? tune;
  String? font;

  Setting({
    this.id,
    this.isNoti,
    this.font,
    this.tune,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isNoti'] = isNoti;
    data['tune'] = tune;
    data['font'] = font;
    return data;
  }

  Setting.fromJson(json, this.id) {
    isNoti = json['isNoti'];
    tune = json['tune'];
    font = json['font'];
  }
}
