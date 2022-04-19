import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

import '../../../core/constants/strings.dart';
import '../../../core/models/home.dart';

class UserDetailViewModel extends BaseViewModel{
   List<HomeData> homeData = [
    HomeData(
        image: '$staticAsset/medical_record.png',
        title: 'Medical Record',
        onTap: () {
         
        }),
    HomeData(
        image: '$staticAsset/pill_reminder.png',
        title: 'Pill Reminder',
        onTap: () {
        }),
    HomeData(
        image: '$staticAsset/symptom.png',
        title: 'Symptom Checker',
        onTap: () {
        }),
    HomeData(
        image: '$staticAsset/consultant.png',
        title: 'Ask the Pharmacist',
        onTap: () {
        }),
    HomeData(
        image: '$staticAsset/my_profile.png',
        title: 'My Profile',
        onTap: () {
        }),
    HomeData(
        image: '$staticAsset/my_condition.png',
        title: 'My Condition',
        onTap: () {
        }),
    HomeData(
        image: '$staticAsset/take_medicines.png',
        title: 'My Medication',
        onTap: () {
        }),
    HomeData(
        image: '$staticAsset/app_settings.png',
        title: 'Settings',
        onTap: () {}),
  ];
}