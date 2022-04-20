import 'dart:io';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/others/screen_utils.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/services/notification_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/style.dart';
import '../../../core/services/file_picker_service.dart';
import '../../../core/services/firebase_storage_service.dart';

class MedicationViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  List<Medicine> medicines = [];
  final NotificationsService _notificationsService = NotificationsService();
  File? image;
  final FilePickerService _filePickerService = FilePickerService();
  String? imageUrl;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();

  MedicationViewModel() {
    getAllMedicines();
  }

  getAllMedicines() async {
    setState(ViewState.busy);
    medicines = [];
    medicines = await _dbService.getAllMedicines(_authService.appUser.id!);
    setState(ViewState.idle);
  }

  getImage() async {
    setState(ViewState.busy);
    image = await _filePickerService.pickImageWithoutCompression();
    if (image != null) {
      debugPrint('image taken');
      Get.dialog(CustomDialog(image, () async {
        Get.back();
        setState(ViewState.busy);
        imageUrl = await _firebaseStorageService.uploadImage(
            image!, 'medicines-images');
        debugPrint('imageUrl => $imageUrl');
        if (imageUrl != null) {
          _dbService.addMedicineImages(_authService.appUser.id!, imageUrl!);
        }
        Get.snackbar('Upload success', 'Image has been added successfully',
            snackPosition: SnackPosition.BOTTOM);
        setState(ViewState.idle);
      }));
    }
    setState(ViewState.idle);
  }

  deleteMedicine(Medicine medicine, int index) async {
    setState(ViewState.busy);
    await _dbService.deleteMedicine(_authService.appUser.id!, medicine);
    for (int i = 0; i < medicines.length; i++) {
      if (medicines[i].id == medicine.id) {
        medicines.remove(medicine);
      }
    }
    _notificationsService.stopNotificaiton(index);
    setState(ViewState.idle);
  }

  setReminder(int index) async {
    setState(ViewState.busy);
    medicines[index].isReminderOpen = !medicines[index].isReminderOpen!;
    await _dbService.updateMedicine(_authService.appUser.id!, medicines[index]);

    if (medicines[index].isReminderOpen == true) {
      if (medicines[index].time1 != null) {
        _notificationsService.schedule(
            index,
            'Pill Reminder',
            'Please take ${medicines[index].pill1} doses of ${medicines[index].name}',
            Time(int.parse(medicines[index].time1!.split(':')[0]),
                int.parse(medicines[index].time1!.split(':')[1])));
      }
      if (medicines[index].time2 != null) {
        _notificationsService.schedule(
            index,
            'Pill Reminder',
            'Please take ${medicines[index].pill2} doses of ${medicines[index].name}',
            Time(int.parse(medicines[index].time2!.split(':')[0]),
                int.parse(medicines[index].time2!.split(':')[1])));
      }
      if (medicines[index].time3 != null) {
        _notificationsService.schedule(
            index,
            'Pill Reminder',
            'Please take ${medicines[index].pill3} doses of ${medicines[index].name}',
            Time(int.parse(medicines[index].time3!.split(':')[0]),
                int.parse(medicines[index].time3!.split(':')[1])));
      }
      Get.snackbar('Start Success', 'Notificatoins successfully started',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      _notificationsService.stopNotificaiton(index);
    }
    setState(ViewState.idle);
  }
}

class CustomDialog extends StatelessWidget {
  final image;
  final onTap;
  const CustomDialog(this.image, this.onTap);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Image', style: headingTextStyleRoboto),
      content: SizedBox(
        height: 0.23.sh,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.file(image, height: 0.2.sh, width: 1.sw, fit: BoxFit.cover),
          SizedBox(height: 14.h),
        ]),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: onTap,
          child: Text(
            'Upload',
            style: bodyTextStyleRoboto,
          ),
        ),
      ],
    );
  }
}
