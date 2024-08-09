import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ControlButtonsWidget extends StatefulWidget {
  final AudioPlayer player;
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
      children: [
        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state.
        StreamBuilder<PlayerState>(
          stream: widget.player.playerStateStream,
          builder: (context, snapshot) =>
              _buildButton(playerState: snapshot.data),
        ),
      ],
    );
  }

  Widget _buildButton({required PlayerState? playerState}) {
    final processingState = playerState?.processingState;

    final isBuffering = processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering;
    final isPlaying = playerState?.playing == true;
    final isCompleted = processingState != ProcessingState.completed;

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
        onPressed: () => widget.player.seek(Duration.zero),
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
