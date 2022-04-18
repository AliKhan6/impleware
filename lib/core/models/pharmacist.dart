class Pharmacist {
  String? id;
  String? email;
  String? name;
  String? username;
  String? imageUrl;

  Pharmacist({
    this.id,
    this.email,
    this.name,
    this.username,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['username'] = username;
    data['imageUrl'] = imageUrl;
    return data;
  }

  Pharmacist.fromJson(json, this.id) {
    email = json['email'];
    name = json['name'];
    username = json['username'];
    imageUrl = json['imageUrl'];
  }
}
