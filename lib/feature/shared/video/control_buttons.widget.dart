import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ControlButtonsWidget extends StatefulWidget {
  final VideoPlayerController player;
  final bool showPauseButton;
  const ControlButtonsWidget({
    required this.player,
    this.showPauseButton = true,
    super.key,
  });

  @override
  _AudioWidgetState createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<ControlButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [_buildButton(playerState: widget.player)],
    );
  }

  Widget _buildButton({required VideoPlayerController playerState}) {
    final isBuffering = playerState.value.isBuffering;
    final isPlaying = playerState.value.isPlaying;
    final isCompleted = playerState.value.isCompleted;

    if (isBuffering) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: const CircularProgressIndicator(),
      );
    } else if (!isPlaying) {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: widget.player.play,
      );
    } else if (widget.showPauseButton && isPlaying) {
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: widget.player.pause,
      );
    } else if (isCompleted) {
      return IconButton(
        icon: const Icon(Icons.replay),
        iconSize: 64.0,
        onPressed: () => widget.player.seekTo(Duration.zero),
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: widget.player.play,
      );
    }
  }
}
