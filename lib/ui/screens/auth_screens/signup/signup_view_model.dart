import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/custom_auth_result.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';
import '../../home/home_screen.dart';

class SignupViewModel extends BaseViewModel {
  bool isShowPassword = true;
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();

  registerUser() async {
    setState(ViewState.busy);
    debugPrint('appUser => ${appUser.toJson()}');
  CustomAuthResult authResult =  await _authService.signUpWithEmailPassword(appUser);
  if(authResult.status == true){
    Get.offAll(() => const HomeScreen());
  }else{
    // Get.dialog()
  }
  }

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
}
