import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:event_app/services/firebase_auth_service.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel(this.locator);

  final Locator locator;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signWithEmailAndPassword(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    _setLoading();
    await locator<FirebaseAuthService>()
        .signWithEmailAndPassword(email, password, errorCallback);
    _setNotLoading();
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
