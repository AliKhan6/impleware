class SymptomChecker {
  String? id;
  String? symptom1;
  String? symptom2;
  String? symptom3;

  SymptomChecker({this.symptom1, this.symptom2, this.symptom3});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptom1'] = symptom1;
    data['symptom2'] = symptom2;
    data['symptom3'] = symptom3;
    return data;
  }

  SymptomChecker.fromJson(json, this.id) {
    symptom1 = json['symptom1'];
    symptom2 = json['symptom2'];
    symptom3 = json['symptom3'];
  }
}
