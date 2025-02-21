import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'landing_model.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import '../models/cart_item.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
export 'landing_model.dart';

class LandingWidget extends StatefulWidget {
  const LandingWidget({super.key});

  @override
  State<LandingWidget> createState() => _LandingWidgetState();
}

class _LandingWidgetState extends State<LandingWidget> {
  late LandingModel _model;
  late YoutubePlayerController _youtubeController;
  bool _isPlaying = false;
  bool _showPlayButton = true;

  final List<String> sermonSlides = [
    'assets/images/Slide1.png',
    'assets/images/Slide2.png',
    'assets/images/Slide3.png',
  ];

  final List<Map<String, dynamic>> shopItems = [
    {
      'id': '1',
      'title': 'Daily Devotional',
      'price': '1,599',
      'image': 'assets/images/book1.jpg',
      'author': 'John Doe',
    },
    {
      'id': '2',
      'title': 'Prayer Journal',
      'price': '1,299',
      'image': 'assets/images/book2.jpg',
      'author': 'Jane Doe',
    },
    {
      'id': '3',
      'title': 'Bible Study Guide',
      'price': '1,999',
      'image': 'assets/images/book3.jpg',
      'author': 'Bob Smith',
    },
    {
      'id': '4',
      'title': 'Worship CD',
      'price': '999',
      'image': 'assets/images/cd1.jpg',
      'author': 'Unknown Author',
    },
    {
      'id': '5',
      'title': 'Christian Living',
      'price': '1,499',
      'image': 'assets/images/book4.jpg',
      'author': 'Alice Johnson',
    },
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LandingModel());
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'n-vVnzpUZIE',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: false,
        enableCaption: true,
      ),
    );

    _youtubeController.addListener(() {
      final isPlaying = _youtubeController.value.isPlaying;
      if (isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = isPlaying;
          if (isPlaying) {
            Future.delayed(Duration(seconds: 2), () {
              if (mounted && _isPlaying) {
                setState(() => _showPlayButton = false);
              }
            });
          } else {
            _showPlayButton = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      extendBodyBehindAppBar: true,
      body: Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Column(
          children: [
            // Status bar space
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            ),
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Welcome Section
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi Jambohost,',
                            style: GoogleFonts.poppins(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Welcome to Kingdom Church',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // YouTube Video Section
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 220,
                                child: YoutubePlayer(
                                  controller: _youtubeController,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  progressColors: ProgressBarColors(
                                    playedColor:
                                        FlutterFlowTheme.of(context).primary,
                                    handleColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                  onReady: () {
                                    setState(() => _showPlayButton = true);
                                  },
                                ),
                              ),
                              if (_showPlayButton)
                                GestureDetector(
                                  onTap: () {
                                    if (_isPlaying) {
                                      _youtubeController.pause();
                                    } else {
                                      _youtubeController.play();
                                    }
                                  },
                                  child: Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      _isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 42,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Trending Sermons Section
                    Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Trending Sermons',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => context.pushNamed('sermons'),
                                  child: Text(
                                    'See All',
                                    style: GoogleFonts.poppins(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 0.8,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                            ),
                            items: sermonSlides.map((item) {
                              return GestureDetector(
                                onTap: () => context.pushNamed('sermons'),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: AssetImage(item),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 2),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Trending Products Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Trending Products',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed('shop');
                                },
                                child: Text(
                                  'See All',
                                  style: GoogleFonts.poppins(
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Products Carousel
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 180,
                              viewportFraction: 0.4,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                            ),
                            items: shopItems.map((item) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        item['image'],
                                        height: 140,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'KES ${item['price']}',
                                      style: GoogleFonts.poppins(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Upcoming Events Section
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            color: FlutterFlowTheme.of(context).primary,
                            child: Text(
                              'UPCOMING EVENTS',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => context.pushNamed('events'),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/upcomingevents.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => context.pushNamed('events'),
                              child: Text(
                                'View All Events',
                                style: GoogleFonts.poppins(
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
