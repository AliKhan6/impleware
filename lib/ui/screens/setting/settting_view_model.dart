import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

class SettingViewModel extends BaseViewModel {
  bool isNoti = false;

  updateNot() {
    isNoti = !isNoti;
    notifyListeners();
  }
}
