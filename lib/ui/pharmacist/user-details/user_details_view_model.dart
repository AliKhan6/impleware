import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/profile/phar_profile_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/medical_record_screen.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../../core/models/home.dart';

class UserDetailViewModel extends BaseViewModel {
  AppUser appUser = AppUser();

  UserDetailViewModel(this.appUser);

  List<HomeData> homeData = [
    HomeData(
        image: '$staticAsset/medical_record.png',
        title: 'Medical Record',
        onTap: () {
         
        }),
    HomeData(
        image: '$staticAsset/my_profile.png',
        title: 'My Profile',
        onTap: () {
          Get.to(() => const PharProfileScreen());
        }),
    HomeData(
        image: '$staticAsset/my_condition.png',
        title: 'User Condition',
        onTap: () {}),
    HomeData(
        image: '$staticAsset/chat.png',
        title: 'Chat',
        onTap: () {
          // Get.to(() => PharChatScreen(stylistUser: appUser));
        }),
    HomeData(
        image: '$staticAsset/gallery.png',
        title: 'Medicine Images',
        onTap: () {
          // Get.to(() => PharChatScreen(stylistUser: appUser));
        }),
  ];
}
