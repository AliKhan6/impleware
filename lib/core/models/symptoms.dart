class Symptoms {
  String? id;
  String? name;
  List<String>? symptoms;

  Symptoms({
    this.id,
    this.name,
    this.symptoms,
  });

  Symptoms.fromJson(json, this.id) {
    name = json['name'];
    if (json['symptoms'] != null) {
      symptoms = [];
      json['symptoms'].forEach((e) {
        symptoms!.add(e);
      });
    }
  }
}
