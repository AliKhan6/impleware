import 'dart:io';

import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/view_state.dart';
import '../../../core/services/file_picker_service.dart';
import '../../../core/services/firebase_storage_service.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  File? image;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final FilePickerService _filePickerService = FilePickerService();
  AppUser appUser = AppUser();
  final _dbService = DatabaseService();

  ProfileViewModel() {
    appUser = authService.appUser;
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
      appUser.imageUrl =
          await _firebaseStorageService.uploadImage(image!, 'userProfile');
    }
    await _dbService.updateClientFcm(appUser, authService.appUser.id);
    authService.appUser = appUser;
    setState(ViewState.idle);
  }
}
