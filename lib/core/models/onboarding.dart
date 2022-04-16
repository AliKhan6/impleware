import 'package:flutter/cupertino.dart';

class Onboarding {
  String? id;
  String? backgroundImage;
  String? image;
  Color? backgroundColor;
  String? title;
  String? description;
  Color? buttonColor;

  Onboarding({
    this.id,
    this.backgroundImage,
    this.image,
    this.backgroundColor,
    this.title,
    this.description,
    this.buttonColor,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['backgroundImage'] = backgroundImage;
    data['image'] = image;
    data['backgroundColor'] = backgroundColor;
    data['title'] = title;
    data['description'] = description;
    data['buttonColor'] = buttonColor;
    return data;
  }

  Onboarding.fromJson(json, id) {
    id = id;
    backgroundImage = json['backgroundImage'];
    image = json['image'];
    backgroundColor = json['backgroundColor'];
    title = json['title'];
    description = json['description'];
    buttonColor = json['buttonColor'];
  }
}
