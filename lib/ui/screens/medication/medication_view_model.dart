import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/medicine.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';

class MedicationViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  List<Medicine> medicines = [];

  MedicationViewModel() {
    getAllMedicines();
  }

  getAllMedicines() async {
    setState(ViewState.busy);
    medicines = await _dbService.getAllMedicines(_authService.appUser.id!);
    setState(ViewState.idle);
  }

  setReminder(int index) {
    medicines[index].isReminderOpen = !medicines[index].isReminderOpen!;
    notifyListeners();
  }
}
