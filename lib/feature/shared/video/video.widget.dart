import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'control_buttons.widget.dart';
import 'seekbar.widget.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  const VideoWidget({
    required this.url,
    super.key,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late final VideoPlayerController _player;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Future<void> _init() async {
    try {
      _player = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
          // play immediately after initialization
          _player.play();
        });
    } catch (e, s) {
      /// TODO: handel the error
      /// make sure url is valid and player is available
      logger.error('loading', e: e, s: s);
    }
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ControlButtonsWidget(player: _player),
        Center(
          child: _player.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _player.value.aspectRatio,
                  child: VideoPlayer(_player),
                )
              : Container(),
        ),
        SeekBarWidget(player: _player),
      ],
    );
  }
}
