import 'package:calkitna_mobile_app/core/models/medicine.dart';

class MedicineImages {
  String? id;
  String? imageUrl;
  DateTime? createdAt;

  MedicineImages({
    this.id,
    this.imageUrl,
    this.createdAt,
  });

  MedicineImages.fromJson(json, this.id) {
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'].toDate();
  }
}
