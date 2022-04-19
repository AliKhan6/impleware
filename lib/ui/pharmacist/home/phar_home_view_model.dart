import 'package:calkitna_mobile_app/core/enums/view_state.dart';
import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/database_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';

class PharHomeViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final _dbService = DatabaseService();
  List<AppUser> users = [];

  PharHomeViewModel() {
    getAllAppUsers();
  }

  getAllAppUsers() async {
    setState(ViewState.busy);
    users = await _dbService.getAppUsers();
    setState(ViewState.idle);
  }
}
