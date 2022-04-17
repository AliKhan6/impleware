class Measurements {
  String? id;
  String? height;
  String? weight;
  String? bodyType;

  Measurements({this.id, this.height, this.weight, this.bodyType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['weight'] = weight;
    data['bodyType'] = bodyType;
    return data;
  }

  Measurements.fromJson(json, this.id) {
    height = json['height'];
    weight = json['weight'];
    bodyType = json['bodyType'];
  }
}
