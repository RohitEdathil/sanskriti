import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:sanskriti/home/home_screen.dart';
import 'package:sanskriti/login/components/custom_input.dart';
import 'package:sanskriti/login/components/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<LoginScreen> {
  final _emailCtrlr = TextEditingController();
  final _pinCtrlr = TextEditingController();

  void _errorPopup(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _login(BuildContext context) async {
    String email = _emailCtrlr.text.trim();
    String pin = _pinCtrlr.text;

    if (email.isEmpty || pin.isEmpty) {
      _errorPopup("Please enter your email and Password", context);
      return;
    }

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: pin,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      final error = e as FirebaseAuthException;
      switch (error.code) {
        case 'user-not-found':
          _errorPopup("Unknown user", context);
          break;
        case 'wrong-password':
          _errorPopup("Wrong Password", context);
          break;

        default:
          _errorPopup("Unknown error", context);
      }
      return;
    }

    if (mounted) {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(child: Image.asset('assets/pattern.png', height: 300)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Namaskaaram!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Find the top artists for your event",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 40),
                    CustomInput(controller: _emailCtrlr),
                    const SizedBox(height: 15),
                    CustomInput(isPassword: true, controller: _pinCtrlr),
                    const SizedBox(height: 10),
                    LoginButton(callback: () => _login(context)),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
