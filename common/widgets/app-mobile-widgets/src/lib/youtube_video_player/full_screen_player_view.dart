import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class FullScreenPlayerView extends StatefulWidget {
  const FullScreenPlayerView({
    Key? key,
    required this.videoId,
    required this.startSeconds,
    required this.interfaceLanguage,
  });

  final String videoId;
  final String interfaceLanguage;
  final double startSeconds;

  @override
  State<FullScreenPlayerView> createState() => _FullScreenPlayerViewState();
}

class _FullScreenPlayerViewState extends State<FullScreenPlayerView>
    with WidgetsBindingObserver {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      startSeconds: widget.startSeconds,
      autoPlay: true,
      params: YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
        interfaceLanguage: widget.interfaceLanguage,
        captionLanguage: widget.interfaceLanguage,
        strictRelatedVideos: true,
        loop: true,
      ),
    );
    /* ..onFullscreenChange = (_) async {
        Navigator.pop(context, await _controller.currentTime);
      }; */

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
        Navigator.pop(context, await _controller.currentTime);
      },
      /* onWillPop: () async {
        Navigator.pop(context, await _controller.currentTime);
        return false;
      }, */
      child: YoutubePlayer(
        controller: _controller,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller.close();

    super.dispose();
  }
}
