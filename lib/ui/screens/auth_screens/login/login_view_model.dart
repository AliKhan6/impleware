import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/custom_auth_result.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/ui/screens/home/home_screen.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class LoginViewModel extends BaseViewModel {
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  bool isShowPassword = true;

  login() async {
    setState(ViewState.busy);
    CustomAuthResult authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    if (authResult.status == true) {
      Get.offAll(() => const HomeScreen());
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
