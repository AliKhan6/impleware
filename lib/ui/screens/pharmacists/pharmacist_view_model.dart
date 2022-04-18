import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/pharmacist.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import '../../../locator.dart';

class PharmacistViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  List<Pharmacist> pharmacists = [];

  PharmacistViewModel() {
    getPharmacists();
  }

  getPharmacists() async {
    setState(ViewState.busy);
    pharmacists = await _dbService.getPharmacists();
    setState(ViewState.idle);
  }
}
