import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/theme_font.dart';
import '../../../shared/audio/audio.widget.dart';
import '../../../shared/image/image.widget.dart';
import '../../../shared/video/video.widget.dart';
import 'boardgame.enum.dart';

class BoardgameWidget extends ConsumerWidget {
  final BoardgameType type;
  final String title;
  final String url;
  const BoardgameWidget({
    required this.type,
    required this.title,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black38,
      child: _buildBody(
        type: type,
        title: title,
        url: url,
      ),
    );
  }

  Widget _buildBody({
    required BoardgameType type,
    required String title,
    required String url,
  }) {
    return switch (type) {
      BoardgameType.text => _buildText(text: title),
      BoardgameType.photo => _buildPhoto(url: url),
      BoardgameType.audio => _buildAudio(url: url),
      BoardgameType.video => _buildVideo(url: url),
    };
  }

  Widget _buildText({required String text}) {
    return Center(
      child: Text(
        text,
        style: ThemeFont.bodyMedium.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildPhoto({required String url}) {
    return ImageWidget(url: url);
  }

  Widget _buildAudio({required String url}) {
    // TODO: remove it
    // just for testing
    url = 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3';
    return AudioWidget(url: url);
  }

  Widget _buildVideo({required String url}) {
    // TODO: remove it
    // just for testing
    url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    return VideoWidget(url: url);
  }
}
