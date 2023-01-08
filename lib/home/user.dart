import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskriti/home/choose_culture.dart';
import 'package:sanskriti/login/login_screen.dart';
import 'package:sanskriti/utils/big_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDashboard extends StatefulWidget {
  final DataSnapshot user;
  const UserDashboard({super.key, required this.user});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  DataSnapshot? data;
  List<String> artistName = [];

  Future<void> fetchUserData() async {
    final result = await FirebaseDatabase.instance
        .ref('requests')
        .orderByChild('userId')
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
                onPressed: () => setState(() {}),
                icon: const Icon(Icons.refresh_rounded)),
            IconButton(
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SpinKitSpinningLines(color: Colors.white));
              }

              return data!.children.isEmpty

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
                          for (var request in data!.children)
                            RequestCard(data: request)
                        ],
                      ),
                    );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BigButton(
            text: 'Explore',
            color: const Color.fromARGB(255, 36, 44, 127),
            icon: Icons.explore,
            callback: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChooseCultureScreen())),
          ),
        ));
  }
}

class RequestCard extends StatefulWidget {
  final DataSnapshot data;
  final VoidCallback? callback;
  const RequestCard({super.key, required this.data, this.callback});

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  DataSnapshot? artist;

  // Match  status to color
  Color _getColor(DataSnapshot snap) {
    switch (snap.child('status').value as int) {
      case -1:
        return Colors.red;
      case 1:
        return Colors.green;

      default:
        return Colors.yellow;
    }
  }

  // Match status to message
  String _getMessage(DataSnapshot snap) {
    switch (snap.child('status').value as int) {
      case -1:
        return "Declined";
      case 1:
        return "Accepted";

      default:
        return "Pending";
    }
  }

  Future<void> _loadData() async {
    artist = await FirebaseDatabase.instance
        .ref('users')
        .child(widget.data.child('artistId').value as String)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            // Loading
            return Container(
              height: 200,
              margin: const EdgeInsets.all(30),
              child: const SpinKitSpinningLines(color: Colors.white),
            );
          }

          return Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 46, 79),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name of artist
                Text(
                  artist!.child('name').value as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(width: 10),

                // Name of Program
                Text(
                  widget.data.child("programName").value as String,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date
                        Row(
                          children: [
                            const Icon(Icons.date_range),
                            const SizedBox(width: 10),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(
                                      widget.data.child("date").value as int)
                                  .toString()
                                  .substring(0, 10),
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),

                        // Location
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 10),
                            Text(
                              widget.data.child("location").value as String,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),

                    // Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: _getColor(widget.data), width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        _getMessage(widget.data),
                        style: TextStyle(color: _getColor(widget.data)),
                      ),
                    ),
                  ],
                ),

                // Contact Button
                if (widget.data.child("status").value == 1 &&
                    widget.data.child("artistId").value !=
                        FirebaseAuth.instance.currentUser!.uid)
                  TextButton.icon(
                      onPressed: () => launchUrl(
                          Uri.parse("tel:${artist!.child('contact').value}")),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.call),
                      label: const Text("Contact")),

                const SizedBox(height: 10),
                // Accept or Decline
                if (widget.data.child("artistId").value ==
                        FirebaseAuth.instance.currentUser!.uid &&
                    widget.data.child('status').value == 0)
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseDatabase.instance
                                .ref('requests')
                                .child(widget.data.key!)
                                .update({'status': 1});
                            setState(() {
                              widget.callback!();
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Accept"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            await FirebaseDatabase.instance
                                .ref('requests')
                                .child(widget.data.key!)
                                .update({'status': -1});
                            setState(() {
                              widget.callback!();
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Decline"),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          );
        });
  }
}
