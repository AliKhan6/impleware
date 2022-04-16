class AppUser {
  String? id;
  String? email;
  String? password;
  String? name;
  String? username;
  String? emirateNumber;
  String? fcmToken;

  AppUser({
    this.id,
    this.email,
    this.password,
    this.name,
    this.username,
    this.emirateNumber,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['username'] = username;
    data['emirateNumber'] = emirateNumber;
    data['fcmToken'] = fcmToken;

    return data;
  }

  AppUser.fromJson(json, id) {
    id = id;
    email = json['email'];
    name = json['name'];
    username = json['username'];
    emirateNumber = json['emirateNumber'];
    fcmToken = json['fcmToken'];
  }
}