import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/custom_app_bar.dart';

class LiveTVWidget extends StatefulWidget {
  const LiveTVWidget({Key? key}) : super(key: key);

  @override
  _LiveTVWidgetState createState() => _LiveTVWidgetState();
}

class _LiveTVWidgetState extends State<LiveTVWidget> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'n-vVnzpUZIE', // Replace with your church's live stream ID
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: true,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Live TV',
        showBackButton: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                progressColors: ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.redAccent,
                ),
                onReady: () {
                  print('Player is ready.');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
