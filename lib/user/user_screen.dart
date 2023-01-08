import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sanskriti/user/request_booking.dart';
import 'package:sanskriti/utils/image_builder.dart';

class UserScreen extends StatelessWidget {
  final DataSnapshot data;

  const UserScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Image.network(
                data.child('image').value as String,
                frameBuilder: imageBuilder,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),

              // Gradient
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 301,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.9, 1],
                      colors: [
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.0),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(1),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          data.child('name').value as String,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              data.child('desc').value as String,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 13),
            ),
          ),
          if (data.child('programs').exists)
            for (var program in data.child('programs').children)
              ProgramDisplay(
                program: program,
                artistId: data.key!,
              )
        ])));
  }
}

class ProgramDisplay extends StatelessWidget {
  final DataSnapshot program;
  final String artistId;
  const ProgramDisplay(
      {super.key, required this.program, required this.artistId});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  program.key as String,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),

                // Rate
                Text(
                  "₹${'${program.child('rate').value as int}'.rupify}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              program.child('desc').value as String,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 13),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white.withOpacity(0.8), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.timer_rounded),
                    const SizedBox(width: 5),
                    Text(
                      program.child('time').value as String,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white.withOpacity(0.8), fontSize: 13),
                    ),
                  ]),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BookingScreen(
                            artistId: artistId,
                            programName: program.key as String,
                          ))),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text("Request"),
                )
              ],
            ),
          ],
        ));
  }
}

extension on String {
  String get rupify {
    final String s = toString();
    final int l = s.length;
    if (l <= 3) return s;
    return '${s.substring(0, l - 3).rupify},${s.substring(l - 3)}';
  }
}
