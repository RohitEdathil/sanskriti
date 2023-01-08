import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanskriti/firebase_options.dart';
import 'package:sanskriti/home/home_screen.dart';
import 'package:sanskriti/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SanskritiApp());
}

class SanskritiApp extends StatelessWidget {
  const SanskritiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xFF070021),
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(255, 7, 0, 33)),
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
