import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/symptoms.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

class SymptomCheckerViewModel extends BaseViewModel {
  final _dbService = DatabaseService();
  List<Symptoms> symptoms = [];

  SymptomCheckerViewModel() {
    getSymptoms();
  }

  getSymptoms() async {
    setState(ViewState.busy);
    symptoms = await _dbService.getSymptoms();
    setState(ViewState.idle); 
  }
}
