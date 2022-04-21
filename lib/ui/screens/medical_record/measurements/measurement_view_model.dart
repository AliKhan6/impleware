import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/measurements.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:get/get.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/database_service.dart';
import '../../../../locator.dart';

class MeasurementViewModel extends BaseViewModel {
  Measurements measurements = Measurements();
  String dropdownValue = 'Adrenal';
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  AppUser? appUser;

  MeasurementViewModel({AppUser? appUser}) {
    if (appUser != null) {
      this.appUser = appUser;
    }
    getPatientRecord();
  }

  getPatientRecord() async {
    setState(ViewState.busy);
    if(appUser != null){
      measurements = await _dbService.getMeasurements(appUser!.id!);
    }else{
      measurements = await _dbService.getMeasurements(_authService.appUser.id!);
    }
    if (measurements.bodyType != null) {
      dropdownValue = measurements.bodyType!;
    }
    setState(ViewState.idle);
  }

  savePatientRecord() async {
    setState(ViewState.busy);
    measurements.bodyType = dropdownValue;
    await _dbService.addMeasurements(measurements, _authService.appUser.id!);
    Get.snackbar(
        'Measurement saved', "Measurements added successfully save to db",
        snackPosition: SnackPosition.BOTTOM);
    setState(ViewState.idle);
  }

  changeDropDown(value) {
    dropdownValue = value;
    notifyListeners();
  }

  List<String> items = [
    'Adrenal',
    'Thyroid',
    'Liver',
    'Ovary',
  ];
}
