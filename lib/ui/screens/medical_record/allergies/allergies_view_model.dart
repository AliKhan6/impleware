import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/allergy.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:get/get.dart';

import '../../../../core/models/app_user.dart';

class AllergyViewModel extends BaseViewModel {
  List<Allergy> allergies = [];
  final _dbService = DatabaseService();
  AppUser? appUser;

  AllergyViewModel({AppUser? appUser}) {
    if (appUser != null) {
      this.appUser = appUser;
    }
    getAllergies();
  }

  getAllergies() async {
    setState(ViewState.busy);
    if(appUser != null){
      allergies = await _dbService.getAllergies();
    }else{
      allergies = await _dbService.getAllergies();
    }
    setState(ViewState.idle);
  }

  selectAllergy(int index) async {
    allergies[index].isSelected = allergies[index].isSelected == 0 ? 1 : 0;
    await _dbService.updateAllergies(
        allergies[index].id!, allergies[index].isSelected!);
    Get.snackbar('Allergy updated', "Allergy successfully updated in db",
        snackPosition: SnackPosition.BOTTOM);
    setState(ViewState.idle);
    notifyListeners();
  }

  updateAllergies(int index) async {
    setState(ViewState.busy);
  }
}
