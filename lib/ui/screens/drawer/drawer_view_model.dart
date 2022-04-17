import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/view_models.dart/base_view_model.dart';
import 'package:calkitna_mobile_app/locator.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/login/login_screen.dart';
import 'package:get/get.dart';

class DrawerViewModel extends BaseViewModel {
  final authService = locator<AuthService>();

  logout() async {
    await authService.logout();
    Get.offAll(() => const LoginScreen());
  }
}
