import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocee_food_recipe/pages/login/login_page.dart';
import 'package:grocee_food_recipe/pages/login/otp_page.dart';
import 'package:grocee_food_recipe/pages/main/main_page.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String actualCode;

  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  FirebaseUser firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(BuildContext context, String phoneNumber) async {
    isLoginLoading = true;

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential auth) async {
          await _auth
              .signInWithCredential(auth)
              .then((AuthResult value) {
            if (value != null && value.user != null) {
              print('Otentikasi berhasil');
              onAuthenticationSuccessful(context, value);
            } else {
              loginScaffoldKey.currentState.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text('Kode tidak valid / otentikasi tidak valid', style: TextStyle(color: Colors.white),),
              ));
            }
          }).catchError((error) {
            loginScaffoldKey.currentState.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text('Ada yang tidak beres, coba lagi nanti', style: TextStyle(color: Colors.white),),
            ));
          });
        },
        verificationFailed: (AuthException authException) {
          print('Error message: ' + authException.message);
          loginScaffoldKey.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text('Format nomor telepon salah. Harap masukkan nomor Anda dalam format E.164. [+] [kode negara] [angka]', style: TextStyle(color: Colors.white),),
          ));
          isLoginLoading = false;
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          actualCode = verificationId;
          isLoginLoading = false;
          await Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OtpPage()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          actualCode = verificationId;
        }
    );
  }

  @action
  Future<void> validateOtpAndLogin(BuildContext context, String smsCode) async {
    isOtpLoading = true;
    final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    await _auth.signInWithCredential(_authCredential).catchError((error) {
      isOtpLoading = false;
      otpScaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text('Salah kode ! Harap masukkan kode terakhir yang diterima.', style: TextStyle(color: Colors.white),),
      ));
    }).then((AuthResult authResult) {
      if (authResult != null && authResult.user != null) {
        print('Otentikasi berhasil');
        onAuthenticationSuccessful(context, authResult);
      }
    });
  }

  Future<void> onAuthenticationSuccessful(BuildContext context, AuthResult result) async {
    isLoginLoading = true;
    isOtpLoading = true;

    firebaseUser = result.user;

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const MainPage()), (Route<dynamic> route) => false);

    isLoginLoading = false;
    isOtpLoading = false;
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (Route<dynamic> route) => false);
    firebaseUser = null;
  }
}