double stringToDouble(String value) {
  if (value.isEmpty) {
    return 0.0;
  } else {
    if (value.contains('.')) {
      return double.parse(value);
    } else {
      return int.parse(value).toDouble();
    }
  }
}