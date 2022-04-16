class PatientRecord {
  String? id;
  String? name;
  String? username;
  String? email;
  String? contact;
  String? gender;
  String? age;

  PatientRecord(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.contact,
      this.gender,
      this.age});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['username'] = username;
    data['contact'] = contact;
    data['gender'] = gender;
    data['age'] = age;
    return data;
  }

  PatientRecord.fromJson(json, id) {
    id = id;
    email = json['email'];
    name = json['name'];
    username = json['username'];
    contact = json['contact'];
    gender = json['gender'];
    age = json['age'];
  }
}
