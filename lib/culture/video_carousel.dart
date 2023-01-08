import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCarousel extends StatelessWidget {
  final String id;
  const VideoCarousel({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
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
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: id,
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.blue,
                  handleColor: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
