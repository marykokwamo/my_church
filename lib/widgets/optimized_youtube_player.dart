import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OptimizedYoutubePlayer extends StatefulWidget {
  final String videoId;
  final bool autoPlay;
  final bool mute;
  final bool showControls;
  final double? aspectRatio;
  final void Function(YoutubeMetaData)? onVideoEnd;

  const OptimizedYoutubePlayer({
    Key? key,
    required this.videoId,
    this.autoPlay = false,
    this.mute = false,
    this.showControls = true,
    this.aspectRatio,
    this.onVideoEnd,
  }) : super(key: key);

  @override
  State<OptimizedYoutubePlayer> createState() => _OptimizedYoutubePlayerState();
}

class _OptimizedYoutubePlayerState extends State<OptimizedYoutubePlayer> with AutomaticKeepAliveClientMixin {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: widget.autoPlay,
        mute: widget.mute,
        controlsVisibleAtStart: widget.showControls,
        enableCaption: true,
        forceHD: true,
        hideControls: !widget.showControls,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && widget.onVideoEnd != null) {
      if (_controller.value.playerState == PlayerState.ended) {
        widget.onVideoEnd?.call(_controller.metadata);
      }
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        // Handle fullscreen
      },
      onExitFullScreen: () {
        // Handle exit fullscreen
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Theme.of(context).primaryColor,
        progressColors: ProgressBarColors(
          playedColor: Theme.of(context).primaryColor,
          handleColor: Theme.of(context).primaryColorDark,
        ),
        aspectRatio: widget.aspectRatio ?? 16 / 9,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: player,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
