import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/patient_record.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:get/get.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../locator.dart';

class PatientRecordViewModel extends BaseViewModel {
  PatientRecord patientRecord = PatientRecord();
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  AppUser? appUser;

  PatientRecordViewModel({AppUser? appUser}) {
    if (appUser != null) {
      this.appUser = appUser;
    }
    getPatientRecord();
  }

  getPatientRecord() async {
    setState(ViewState.busy);
    if(appUser != null){
      patientRecord = await _dbService.getPatientRecord(appUser!.id!);
    }else{
      patientRecord = await _dbService.getPatientRecord(_authService.appUser.id!);
    }
    setState(ViewState.idle);
  }

  savePatientRecord() async {
    setState(ViewState.busy);
    await _dbService.addPatientRecord(patientRecord, _authService.appUser.id!);
    Get.snackbar('Record saved', "Your record successfully save to db",
        snackPosition: SnackPosition.BOTTOM);
    setState(ViewState.idle);
  }
}
