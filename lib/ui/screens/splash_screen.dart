import 'package:calkitna_mobile_app/core/constants/strings.dart';
import 'package:calkitna_mobile_app/core/constants/style.dart';
import 'package:calkitna_mobile_app/core/others/screen_utils.dart';
import 'package:calkitna_mobile_app/core/services/auth_service.dart';
import 'package:calkitna_mobile_app/core/services/locato_storage_service.dart';
import 'package:calkitna_mobile_app/core/services/notification_service.dart';
import 'package:calkitna_mobile_app/ui/custom_widgets/image_container.dart';
import 'package:calkitna_mobile_app/ui/pharmacist/home/phar_home_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/auth_screens/login/login_screen.dart';
import 'package:calkitna_mobile_app/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locator.dart';
import 'onboarding/onboarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthService>();
  final _localStorateService = locator<LocalStorageService>();
  final _notificationService = locator<NotificationsService>();

  init() async {
    await _localStorateService.init();
    await _notificationService.init();
    await Future.delayed(const Duration(milliseconds: 600));
    await _authService.init();

    if (_localStorateService.onBoardingPageCount <= 2) {
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      return;
    }
    ////
    ///checking if the user is login or not
    ///
    debugPrint('Login State: ${_authService.isLogin}');
    if (_authService.isLogin) {
      _localStorateService.setOnBoardingPageCount = 4;
      Get.off(() => const HomeScreen());
    } else if (_authService.isPharmacist) {
      Get.off(() => const PharHomeScreen());
    } else {
      Get.off(() => const LoginScreen());
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(),
      ImageContainer(assetImage: '$staticAsset/logo.png', height: 0.3.sh),
      Text(
        'You Health Partner',
        style: headingTextStyleRoboto.copyWith(fontStyle: FontStyle.italic),
      ),
    ]));
  }
}
