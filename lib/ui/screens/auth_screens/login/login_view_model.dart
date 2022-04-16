import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  bool isShowPassword = true;

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
}
