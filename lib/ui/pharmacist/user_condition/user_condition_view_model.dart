import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/models/symptom_checker.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:get/get.dart';

class UserConditionViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  List<Medicine> medicines = [];
  List<SymptomChecker> symptoms = [];
  AppUser appUser = AppUser();
  SymptomChecker updateSymptoms = SymptomChecker();

  UserConditionViewModel(this.appUser) {
    getMySymptoms();
    getMyMedicines();
  }

  getMySymptoms() async {
    setState(ViewState.busy);
    symptoms = await _dbService.getMySymptoms(appUser.id!);
    if (symptoms.isNotEmpty) {
      updateSymptoms = symptoms[0];
    }
    setState(ViewState.idle);
  }

  getMyMedicines() async {
    setState(ViewState.busy);
    medicines = await _dbService.getAllMedicines(appUser.id!);
    setState(ViewState.idle);
  }

  addSymptoms() async {
    setState(ViewState.busy);
    Get.back();
    if (symptoms.isEmpty) {
      await _dbService.addMySymptoms(appUser.id!, updateSymptoms);
    } else {
      await _dbService.updateMySymptoms(appUser.id!, updateSymptoms);
    }
    setState(ViewState.idle);
  }
}
