import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication localAuth = LocalAuthentication();
  final _inputController = TextEditingController();

  var pinValidationMessage = '';

  void useBiometrics() async {
    if (await localAuth.canCheckBiometrics) {
      var available = await localAuth.getAvailableBiometrics();
      if (available.isNotEmpty) {
        final bool didAuthenticate = await localAuth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            options: const AuthenticationOptions(biometricOnly: true));
        if (didAuthenticate) {
          navigateHome();
        }
      } else {
      usePin();
    }
    } else {
      usePin();
    }
  }

  void usePin() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25,),
            const Text('Enter PIN: 1111', style: TextStyle( fontSize: 20),),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 75,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 20,
                    
                  ),
                  controller: _inputController,
                  onSubmitted: (value) {
                    if (value == '1111') {
                      navigateHome();
                    } else {
                      pinValidationMessage = 'Wrong pin';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    
                    hintText: '1111',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Text(
              pinValidationMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sunset.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        useBiometrics();
                      },
                      child: const Center(child: Text('Aanmelden'))),
                ),
              ),
            ],
          )),
    );
  }
}
