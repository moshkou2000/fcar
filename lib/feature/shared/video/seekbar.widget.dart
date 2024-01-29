import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SeekBarWidget extends StatelessWidget {
  final VideoPlayerController player;
  const SeekBarWidget({
    required this.player,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      player,
      allowScrubbing: false,
      colors: const VideoProgressColors(
          backgroundColor: Colors.blueGrey,
          bufferedColor: Colors.blueGrey,
          playedColor: Colors.blueAccent),
    );
  }
}
