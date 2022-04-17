import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/allergy.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

class AllergyViewModel extends BaseViewModel {
  List<Allergy> allergies = [];
  final _dbService = DatabaseService();

  AllergyViewModel() {
    getAllergies();
  }

  getAllergies() async {
    setState(ViewState.busy);
    allergies = await _dbService.getAllergies();
    setState(ViewState.idle);
  }

  selectAllergy(int index) {
    allergies[index].isSelected = allergies[index].isSelected == 0 ? 1 : 0;
    notifyListeners();
  }
}
