import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/google_signin_service.dart'; // your existing service

class AuthenticationController with ChangeNotifier {
  final AuthenticationService auth = AuthenticationService();

  GoogleSignInAccount? user;

  User? phoneUser;

  String? _verificationId;

  //Google Auth
  Future<void> login() async {
    final account = await auth.signinWithGoogle();
    if (account != null) {
      user = account;
    }
    notifyListeners();
  }

  //Phone Auth
  Future<void> sendOTP({
    required String phoneNumber,
    required Function onCodeSent,
    required Function(String error) onError,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId) {
        _verificationId = verificationId;
        onCodeSent();
      },
      onError: (err) => onError(err),
    );
  }

  Future<bool> verifyOTP(String smsCode) async {
    if (_verificationId == null) return false;

    UserCredential? result = await auth.verifyOTP(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );

    if (result != null) {
      phoneUser = result.user;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await auth.logout();
    user = null;
    phoneUser = null;
    notifyListeners();
  }
}
