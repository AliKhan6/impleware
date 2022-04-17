import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/allergies/allergies_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/measurements/measurement_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/patient_record/patient_record_screen.dart';
import 'package:get/get.dart';

class MedicalRecordViewModel extends BaseViewModel {
  List<Record> records = [
    Record(
        title: 'Patient Record',
        onTap: () {
          Get.to(() => const PatientRecordScreen());
        },
        image: '$staticAsset/icon.png'),
    Record(
        title: 'Allergies',
        onTap: () {
          Get.to(() => const AllergiesScreen());
        },
        image: '$staticAsset/icon.png'),
    Record(
        title: 'Measurements',
        onTap: () {
          Get.to(() => const MeasurementScreen());
        },
        image: '$staticAsset/icon.png'),
    Record(
        title: 'Documents & reports',
        onTap: () {},
        image: '$staticAsset/icon.png'),
  ];
}

class Record {
  String? title;
  String? image;
  var onTap;

  Record({
    this.title,
    this.image,
    this.onTap,
  });
}
