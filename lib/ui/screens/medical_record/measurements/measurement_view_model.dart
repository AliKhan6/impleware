import 'package:calkitna_mobile_app/core/models/measurements.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

class MeasurementViewModel extends BaseViewModel {
  Measurements measurements = Measurements();
  String dropdownValue = 'Adrenal';

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
