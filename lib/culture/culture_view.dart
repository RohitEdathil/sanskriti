import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sanskriti/artform/artform_screen.dart';
import 'package:sanskriti/culture/section_components.dart';
import 'package:sanskriti/culture/video_carousel.dart';
import 'package:sanskriti/utils/gradient_image_tile.dart';
import 'package:sanskriti/utils/image_builder.dart';

class CultureView extends StatelessWidget {
  final DataSnapshot data;
  const CultureView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Column(children: [
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

          // Videos
          const SectionHeader(
            icon: Icons.live_tv_rounded,
            title: 'Watch',
          ),
          VideoCarousel(id: data.child('video').value as String),

          // Artforms (Only if exists)
          if (data.child('arts').exists)
            const SectionHeader(
              icon: Icons.music_note,
              title: 'Artforms',
            ),
          if (data.child('arts').exists)
            for (var art in data.child('arts').value as List)
              GradientTile(
                imageUrl: art['image'],
                title: art['name'],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtformScreen(
                      data: art,
                    ),
                  ),
                ),
              )
        ])));
  }
}
