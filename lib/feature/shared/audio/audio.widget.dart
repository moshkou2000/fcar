import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'control_buttons.widget.dart';
import 'seekbar.widget.dart';

class AudioWidget extends StatefulWidget {
  final String url;
  const AudioWidget({
    required this.url,
    super.key,
  });

  @override
  _AudioWidgetState createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final _player = AudioPlayer();

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<_PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, _PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => _PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

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
    // Listen to errors during playback.
    _player.playbackEventStream.listen(
      null,
      onError: (e, s) {
        logger.error('playback', e: e, s: s);
      },
    );
    // Load from url
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.url)));
      // play immediately after initialization
      _player.play();
    } catch (e, s) {
      logger.error('loading', e: e, s: s);
    }
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ControlButtonsWidget(player: _player),
        StreamBuilder<_PositionData>(
          stream: _positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return SeekBarWidget(
              duration: positionData?.duration ?? Duration.zero,
              position: positionData?.position ?? Duration.zero,
              bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
              onChangeEnd: _player.seek,
            );
          },
        ),
      ],
    );
  }
}

class _PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  _PositionData(this.position, this.bufferedPosition, this.duration);
}
