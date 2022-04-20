import 'dart:io';

import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/services/file_picker_service.dart';
import 'package:calkitna_mobile_app/core/services/firebase_storage_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/enums/view_state.dart';

class AddMedicineViewModel extends BaseViewModel {
  TimeOfDay selectedTime1 = const TimeOfDay(hour: 09, minute: 00);
  TimeOfDay selectedTime2 = const TimeOfDay(hour: 09, minute: 00);
  TimeOfDay selectedTime3 = const TimeOfDay(hour: 09, minute: 00);
  int everyday = 0;
  int everyMonday = 0;
  int everySunday = 0;
  File? image;
  final FilePickerService _filePickerService = FilePickerService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  Medicine medicine = Medicine();

  AddMedicineViewModel({Medicine? medicine}) {
    if (medicine != null) {
      this.medicine = medicine;
      everyday = 1;
    }
  }

  getImageUrl() async {
    medicine.imageUrl =
        await _firebaseStorageService.uploadImage(image!, 'medicines');
    debugPrint('imageUrl => ${medicine.imageUrl}');
  }

  storeNewMedicine(List<Medicine> list) async {
    setState(ViewState.busy);
    if (image != null) {
      await getImageUrl();
    }
    medicine.createdAt = DateTime.now();
    debugPrint('medicine => ${medicine.toJson()}');
    await _dbService.addMedicine(_authService.appUser.id!, medicine);
    list.add(medicine);
    Get.back(result: list);
    Get.snackbar('Upload success', 'Medicine has been added successfully');
    setState(ViewState.idle);
  }

  update(List<Medicine> list) async {
    setState(ViewState.busy);
    if (image != null) {
      await getImageUrl();
    }
    medicine.createdAt = DateTime.now();
    debugPrint('medicine => ${medicine.toJson()}');
    await _dbService.updateMedicine(_authService.appUser.id!, medicine);
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == medicine.id) {
        list[i] = medicine;
      }
    }
    Get.back(result: list);
    Get.snackbar('Update success', 'Medicine has been updated successfully');
    setState(ViewState.idle);
  }

  getImage() async {
    setState(ViewState.busy);
    medicine.imageUrl = null;
    image = await _filePickerService.pickImageWithoutCompression();
    if (image != null) {
      debugPrint('image taken');
    }
    setState(ViewState.idle);
  }

  selectNewSchedule(int value) {
    if (value == 0) {
      everyday = 1;
      everyMonday = 0;
      everySunday = 0;
      medicine.schedule = 'Everyday';
    } else if (value == 1) {
      everyday = 0;
      everyMonday = 1;
      everySunday = 0;
      medicine.schedule = 'Every Monday';
    } else {
      everyday = 0;
      everyMonday = 0;
      everySunday = 1;
      medicine.schedule = 'Every Sunday';
    }
    notifyListeners();
  }

  shoPicker1(context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime1,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      selectedTime1 = timeOfDay;
      // if (selectedTime1.hour == 0) {
      medicine.time1 = '${selectedTime1.hour}:${selectedTime1.minute}';
      // medicine.time1 =
      //     '${selectedTime1.hour + 12}:${selectedTime1.minute} am';
      // } else if (selectedTime1.hour < 12) {
      //   medicine.time1 = '${selectedTime1.hour}:${selectedTime1.minute}';
      //   // medicine.time1 = '${selectedTime1.hour}:${selectedTime1.minute} am';
      // } else if (selectedTime1.hour > 12) {
      //   medicine.time1 = '${selectedTime1.hour}:${selectedTime1.minute}';
      //   // medicine.time1 =
      //   //     '${selectedTime1.hour - 12}:${selectedTime1.minute} pm';
      // }
      setState(ViewState.idle);
    }
    notifyListeners();
  }

  shoPicker2(context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      selectedTime2 = timeOfDay;
      medicine.time2 = '${selectedTime2.hour}:${selectedTime2.minute}';
      setState(ViewState.idle);
    }
    notifyListeners();
  }

  shoPicker3(context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime3,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      selectedTime3 = timeOfDay;
      medicine.time3 = '${selectedTime3.hour}:${selectedTime3.minute}';
      setState(ViewState.idle);
    }
    notifyListeners();
  }
}
