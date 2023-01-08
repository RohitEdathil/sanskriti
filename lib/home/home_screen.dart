import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskriti/home/artist.dart';
import 'package:sanskriti/home/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataSnapshot? data;

  Future<void> fetchUserData() async {
    final result = await FirebaseDatabase.instance
        .ref('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .once();
    data = result.snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: SpinKitSpinningLines(color: Colors.white)),
          );
        } else {
          if (data!.child('is_artist').value == true) {
            return ArtistDashboard(user: data!);
          } else {
            return UserDashboard(user: data!);
          }
        }
      },
    );
  }
}
