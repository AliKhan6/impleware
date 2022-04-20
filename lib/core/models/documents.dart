class Documents {
  String? id;
  String? url;
  String? title;

  Documents({
    this.id,
    this.url,
    this.title,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['url'] = url;
    data['title'] = title;
    return data;
  }

  Documents.fromJson(json, this.id) {
    url = json['url'];
    title = json['title'];
  }
}
