import 'package:calkitna_mobile_app/core/models/app_user.dart';
import 'package:calkitna_mobile_app/core/models/custom_auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_exception_service.dart';
import 'database_service.dart';

class AuthService extends ChangeNotifier {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  CustomAuthResult customAuthResult = CustomAuthResult();
  User? user;
  bool isLogin = false;
  AppUser appUser = AppUser();

  AuthService() {
    init();
  }
  init() async {
    // logout();
    user = _auth.currentUser;
    if (user != null) {
      isLogin = true;

      appUser = (await _dbService.getAppUser(user!.uid));
    } else {
      isLogin = false;
    }
  }

  /// [SignUp] with email and password function
  ///
  Future<CustomAuthResult> signUpWithEmailPassword(AppUser appUser) async {
    debugPrint('@services/singUpWithEmailPassword');
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: appUser.email!, password: appUser.password!);

      /// If user signup fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        appUser.id = credentials.user!.uid;
        this.appUser = appUser;

        await _dbService.registerAppUser(appUser);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  /// [Login] with email and password function
  ///
  Future<CustomAuthResult> loginWithEmailPassword({email, password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }

      ///
      /// If firebase auth is successful:
      ///
      if (credentials.user != null) {
        appUser = await _dbService.getAppUser(credentials.user!.uid);
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
      }
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  Future<void> logout({id}) async {
    await _auth.signOut();
    this.isLogin = false;
    this.user = null;
  }
}


 
  // signupWithFacebook() async {
  //   //Todo: Do settings in the Google cloud for 0Auth Credentials
  //   try {
  //     final LoginResult result = await _facebookSignIn.login();
  //     print('Facebook login => ${result.message}');
  //     if (result.status == LoginStatus.success) {
  //       print('Facebook login result success');
  //       final AccessToken accessToken = result.accessToken!;
  //       print("AccessToken::FaceAuth => ${accessToken.token}");
  //       final firebaseAuthCred =
  //           FacebookAuthProvider.credential(accessToken.token);
  //       final loginResult =
  //           await FirebaseAuth.instance.signInWithCredential(firebaseAuthCred);
  //       final userData = await FacebookAuth.instance.getUserData();
  //       this.clientUser = ClientUser();

  //       /// Get user data
  //       clientUser!.id = loginResult.user!.uid;
  //       clientUser!.name = userData['name'];
  //       clientUser!.email = userData['email'];
  //       print(userData['picture']['data']['url']);
  //       print('facebook login => ${clientUser!.name}');
  //       customAuthResult.status = true;
  //       customAuthResult.user = clientUser;
  //       await _dbService.registerClient(clientUser!);

  //       // Todo: Create Account in Database
  //     } else {
  //       customAuthResult.status = false;
  //       customAuthResult.errorMessage = 'An undefined error happened.';
  //     }
  //   } catch (e) {
  //     print('Exception @sighupWithFacebook: $e');
  //     customAuthResult.status = false;
  //     // customAuthResult.errorMessage =
  //     //     AuthExceptionsService.generateExceptionMessage(e);
  //   }
  //   return customAuthResult;
  // }

  ///
  /// Google SignIn
  ///
  // Future<CustomAuthResult> loginWithGoogle() async {
  //   //Todo: Do settings in the Google cloud for 0Auth Credentials
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final authResult = await _auth.signInWithCredential(credential);
  //     print('register user => ${authResult.user!.uid}');

  //     if (authResult.user!.uid != null) {
  //       customAuthResult.status = true;
  //       clientUser = ClientUser();
  //       customAuthResult.user = authResult.user;
  //       clientUser!.id = authResult.user!.uid;
  //       clientUser!.email = authResult.user!.email;
  //       clientUser!.name = authResult.user!.displayName ?? '';

  //       print('Google sign in Client username => ${clientUser!.name}');

  //       await _dbService.registerClient(clientUser!);

  //       //Todo: Create Account in Database
  //     } else {
  //       customAuthResult.status = false;
  //       customAuthResult.errorMessage = 'An undefined error happened.';
  //     }
  //   } catch (e) {
  //     print('Exception @sighupWithGoogle: $e');
  //     customAuthResult.status = false;
  //     // customAuthResult.errorMessage =
  //     //     AuthExceptionsService.generateExceptionMessage(e);
  //   }
  //   return customAuthResult;
  // }