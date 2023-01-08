import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskriti/user/user_screen.dart';
import 'package:sanskriti/utils/image_builder.dart';

class ArtistCarousel extends StatelessWidget {
  final List artists;
  const ArtistCarousel({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (final artist in artists) ArtistCard(artist: artist),
          ],
        ),
      ),
    );
  }
}

class ArtistCard extends StatefulWidget {
  final String artist;
  const ArtistCard({super.key, required this.artist});

  @override
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  DataSnapshot? data;

  Future<void> getData() async {
    data =
        await FirebaseDatabase.instance.ref('users').child(widget.artist).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 150,
                width: 150,
                child: const Center(
                  child: SpinKitSpinningLines(
                    color: Colors.white,
                  ),
                ));
          }

          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserScreen(data: data!),
                )),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(87, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        data!.child('image').value! as String,
                        fit: BoxFit.cover,
                        frameBuilder: imageBuilder,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: SizedBox(
                      width: 150,
                      child: Text(
                        data!.child('name').value! as String,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
