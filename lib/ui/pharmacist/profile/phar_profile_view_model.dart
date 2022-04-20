import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';

import '../../../core/services/auth_service.dart';
import '../../../locator.dart';

class PharProfileViewModel extends BaseViewModel{
  final authService = locator<AuthService>();

}