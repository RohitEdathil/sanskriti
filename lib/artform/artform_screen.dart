import 'package:flutter/material.dart';
import 'package:sanskriti/artform/artist_carousel.dart';
import 'package:sanskriti/culture/section_components.dart';
import 'package:sanskriti/culture/video_carousel.dart';
import 'package:sanskriti/utils/image_builder.dart';

class ArtformScreen extends StatelessWidget {
  final Map data;
  const ArtformScreen({super.key, required this.data});

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
                data['image'],
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
                          data['name'],
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

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              data['desc'],
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 13),
            ),
          ),

          // Video
          const SectionHeader(
            icon: Icons.live_tv_rounded,
            title: 'Watch',
          ),
          VideoCarousel(id: data['video']),

          // Artists (only if there are any)
          if (data['artists'] != null)
            const SectionHeader(
              icon: Icons.person,
              title: 'Atrists',
            ),
          if (data['artists'] != null)
            ArtistCarousel(
              artists: data['artists'] as List,
            ),
          const SizedBox(height: 100)
        ])));
  }
}
