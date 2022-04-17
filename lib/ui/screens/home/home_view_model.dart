import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/models/home.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/medical_record_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/medication/medication_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class HomeViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  List<HomeData> searchedList = [];

  searching(String keyword) {
    searchedList = homeData
        .where((e) => (e.title!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();
    notifyListeners();
  }

  List<HomeData> homeData = [
    HomeData(
        image: '$staticAsset/medical_record.png',
        title: 'Medical Record',
        onTap: () {
          Get.to(() => const MedicalRecordScreen());
        }),
    HomeData(
        image: '$staticAsset/pill_reminder.png',
        title: 'Pill Reminder',
        onTap: () {}),
    HomeData(
        image: '$staticAsset/symptom.png',
        title: 'Symptom Checker',
        onTap: () {}),
    HomeData(
        image: '$staticAsset/consultant.png',
        title: 'Ask the Pharmacist',
        onTap: () {}),
    HomeData(
        image: '$staticAsset/my_profile.png',
        title: 'My Profile',
        onTap: () {
          Get.to(() => const ProfileScreen());
        }),
    HomeData(
        image: '$staticAsset/my_condition.png',
        title: 'My Condition',
        onTap: () {}),
    HomeData(
        image: '$staticAsset/take_medicines.png',
        title: 'My Medication',
        onTap: () {
          Get.to(() => const MedicationScreen());
        }),
    HomeData(
        image: '$staticAsset/app_settings.png',
        title: 'Settings',
        onTap: () {}),
  ];
}
