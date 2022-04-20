import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:get/get.dart';

import '../../../core/services/locato_storage_service.dart';
import '../../screens/auth_screens/login/login_screen.dart';

class PharHomeViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final _dbService = DatabaseService();
  List<AppUser> users = [];
  List<AppUser> searchedList = [];
  final _localStorageService = locator<LocalStorageService>();

  PharHomeViewModel() {
    getAllAppUsers();
  }

  searching(String keyword) {
    searchedList = users
        .where((e) => (e.name!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();
    notifyListeners();
  }

  getAllAppUsers() async {
    setState(ViewState.busy);
    users = await _dbService.getAppUsers();
    setState(ViewState.idle);
  }

  logout() async {
    _localStorageService.setPharmacisAccessToken = null;
    await authService.logout();
    Get.offAll(() => const LoginScreen());
  }
}
