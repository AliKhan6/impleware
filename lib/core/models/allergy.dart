class Allergy {
  String? id;
  String? type;
  int? isSelected;

  Allergy({this.type, this.isSelected});

  Allergy.fromJson(json, this.id) {
    type = json['type'];
    isSelected = json['isSelected'];
  }
}
