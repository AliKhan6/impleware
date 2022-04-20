import 'dart:io';
import 'package:calkitna_mobile_app/core/models/pharmacist.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:flutter/material.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/database_service.dart';
import '../../../core/services/file_picker_service.dart';
import '../../../core/services/firebase_storage_service.dart';
import '../../../locator.dart';

class PharProfileViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  File? image;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final FilePickerService _filePickerService = FilePickerService();
  Pharmacist pharmacist = Pharmacist();
  final _dbService = DatabaseService();

  PharProfileViewModel() {
    pharmacist = authService.pharmacist;
  }

  getImage() async {
    setState(ViewState.busy);
    image = await _filePickerService.pickImageWithoutCompression();
    if (image != null) {
      debugPrint('image taken');
    }
    setState(ViewState.idle);
  }

  saveData() async {
    setState(ViewState.busy);
    if (image != null) {
      pharmacist.imageUrl = await _firebaseStorageService.uploadImage(
          image!, 'pharmacistProfile');
    }
    await _dbService.updatePharmacist(pharmacist, authService.pharmacist.id);
    authService.pharmacist = pharmacist;
    setState(ViewState.idle);
  }
}
