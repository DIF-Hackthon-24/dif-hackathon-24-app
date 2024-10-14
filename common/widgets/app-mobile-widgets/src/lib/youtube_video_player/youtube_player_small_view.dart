import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubePlayerSmallViewAttributes {
  final String videoUrl;
  final bool autoPlay;
  final String interfaceLanguage;
  YouTubePlayerSmallViewAttributes({
    required this.videoUrl,
    required this.interfaceLanguage,
    this.autoPlay = false,
  });
}

class YouTubePlayerSmallView extends StatefulWidget {
  YouTubePlayerSmallView({
    required this.attributes,
    required this.controller,
    super.key,
  });

  final YouTubePlayerSmallViewAttributes attributes;
  final YoutubePlayerController controller;

  @override
  State<YouTubePlayerSmallView> createState() => _YouTubePlayerSmallViewState();
}

class _YouTubePlayerSmallViewState extends State<YouTubePlayerSmallView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* widget.controller = YoutubePlayerController.fromVideoId(
      autoPlay: widget.attributes.autoPlay,
      videoId: YoutubePlayerController.convertUrlToId(
            widget.attributes.videoUrl,
          ) ??
          '',
      params: YoutubePlayerParams(
        showFullscreenButton: true,
        interfaceLanguage: widget.attributes.interfaceLanguage,
        captionLanguage: widget.attributes.interfaceLanguage,
        strictRelatedVideos: true,
      ),
    ); */
    return YoutubePlayer(
      key: ObjectKey(widget.controller),
      enableFullScreenOnVerticalDrag: false,
      controller: widget.controller,
        /* ..onFullscreenChange = (_) async {
          final videoData = await widget.controller.videoData;
          final startSeconds = await widget.controller.currentTime;
          final currentTime = await Navigator.push<double>(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenPlayerView(
                videoId: videoData.videoId,
                startSeconds: startSeconds,
                interfaceLanguage: widget.attributes.interfaceLanguage,
              ),
            ),
          );

          if (currentTime != null) {
            await widget.controller.seekTo(seconds: currentTime);
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }
        }, */
    );
  }
}
