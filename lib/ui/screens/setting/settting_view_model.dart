import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/settings.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

import '../../../locator.dart';

class SettingViewModel extends BaseViewModel {
  bool isNoti = false;
  String selectedTune = 'Tune1';
  Setting setting = Setting();
  final _dbService = DatabaseService();
  final _authService = locator<AuthService>();
  List<String> tunes = ['Tune1', 'Tune2', 'Tune3', 'Tune4'];
  List<String> fonts = ['smaller', 'greater', 'Tune3', 'Tune4'];

  SettingViewModel() {
    getSetting();
  }

  getSetting() async {
    setState(ViewState.busy);
    setting = await _dbService.getSettins(_authService.appUser.id!);
    if (setting.tune != null) {
      selectedTune = setting.tune!;
    }
    if (setting.isNoti != null) {
      isNoti = setting.isNoti!;
    }

    setState(ViewState.idle);
  }

  save() async {
    setState(ViewState.busy);
    setting.isNoti = isNoti;
    setting.tune = selectedTune;
    await _dbService.addSettins(_authService.appUser.id!, setting);
    setState(ViewState.idle);
  }

  updateNot() {
    isNoti = !isNoti;
    notifyListeners();
  }

  changeDropDown(value) {
    selectedTune = value;
    notifyListeners();
  }

  addSetting() async {}
}
