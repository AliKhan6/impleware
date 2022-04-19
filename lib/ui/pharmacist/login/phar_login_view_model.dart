import 'package:calkitna_mobile_app/core/models/pharmacist.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/home/phar_home_screen.dart';
import 'package:get/get.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/custom_auth_result.dart';

class PharLoginViewModel extends BaseViewModel {
  Pharmacist appUser = Pharmacist();
  final _authService = locator<AuthService>();
  bool isShowPassword = true;

  login() async {
    setState(ViewState.busy);
    CustomAuthResult authResult = await _authService.loginPharWithEmailPassword(
        email: appUser.email, password: appUser.password);
    if (authResult.status == true) {
      Get.offAll(() => const PharHomeScreen());
    } else {
      Get.defaultDialog(
          title: 'Error Login',
          middleText: authResult.errorMessage ??
              'An error occured while login.\nCheck you internet and try again.');
    }
  }

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
}
