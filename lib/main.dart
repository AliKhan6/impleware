import 'package:calkitna_mobile_app/core/constants/colors.dart';
import 'package:calkitna_mobile_app/core/others/screen_utils.dart';
import 'package:calkitna_mobile_app/ui/screens/medical_record/documents/documents_view_model.dart';
import 'package:calkitna_mobile_app/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DocumentsViewModel())
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Impleware',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: primaryColor),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
