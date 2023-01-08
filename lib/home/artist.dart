import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskriti/home/user.dart';
import 'package:sanskriti/login/login_screen.dart';

class ArtistDashboard extends StatefulWidget {
  final DataSnapshot user;

  const ArtistDashboard({super.key, required this.user});

  @override
  State<ArtistDashboard> createState() => _ArtistDashboardState();
}

class _ArtistDashboardState extends State<ArtistDashboard> {
  late DataSnapshot data;

  Future<void> fetchUserData() async {
    final result = await FirebaseDatabase.instance
        .ref('requests')
        .orderByChild('artistId')
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .once();
    data = result.snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Requests'),
        actions: [
          IconButton(

              // Sign out
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              icon: const Icon(Icons.power_settings_new))
        ],
      ),
      body: FutureBuilder(
          future: fetchUserData(),
          builder: (context, snapshot) {
            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SpinKitSpinningLines(color: Colors.white));
            }

            return data.children.isEmpty

                // Empty filler
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      "Press Explore to add a request",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 30),
                    ),
                  ))
                // Requests
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var request in data.children)
                          RequestCard(
                            data: request,
                            callback: () => setState(() {}),
                          )
                      ],
                    ),
                  );
          }),
    );
  }
}
