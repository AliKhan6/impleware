import 'dart:io';
import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/documents.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/file_picker_service.dart';
import '../../../../core/services/firebase_storage_service.dart';

class DocumentsViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  List<Documents> images = [];
  Documents documents = Documents();
  AppUser? appUser;
  File? image;
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  final FilePickerService _filePickerService = FilePickerService();

  DocumentsViewModel({AppUser? appUser}) {
    if (appUser != null) {
      this.appUser = appUser;
    }
    getDocuments();
  }

  getImage() async {
    setState(ViewState.busy);
    image = await _filePickerService.pickImageWithoutCompression();
    if (image != null) {
      debugPrint('image taken');
    }
    setState(ViewState.idle);
  }

  addDocument() async {
    setState(ViewState.busy);
    Get.back();
    if (image != null) {
      documents.url =
          await _firebaseStorageService.uploadImage(image!, 'documents');
    }
    await _dbService.addDocument(locator<AuthService>().appUser.id!, documents);
    images.add(documents);
    image = null;
    Get.snackbar('Upload Success', "Document uploaded successfully",
        snackPosition: SnackPosition.BOTTOM);
    setState(ViewState.idle);
  }

  getDocuments() async {
    setState(ViewState.busy);
    if (appUser != null) {
      images = await _dbService.getDocuments(appUser!.id!);
    } else {
      images =
          await _dbService.getDocuments(locator<AuthService>().appUser.id!);
    }
    setState(ViewState.idle);
  }
}
