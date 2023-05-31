import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LoginViewModel with ChangeNotifier {
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<bool> authBiometrics() async {
    if (await localAuth.canCheckBiometrics) {
      return await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(biometricOnly: true));
    } else {
      return await localAuth.canCheckBiometrics;
    }
  }
}
