import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../design_system/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveTVWidget extends StatefulWidget {
  const LiveTVWidget({Key? key}) : super(key: key);

  @override
  _LiveTVWidgetState createState() => _LiveTVWidgetState();
}

class _LiveTVWidgetState extends State<LiveTVWidget> {
  late YoutubePlayerController _youtubeController;
  late DateTime _selectedDate;
  late ScrollController _calendarController;
  late PageController _eventsController;
  bool _isPlaying = false;
  bool _showPlayButton = true;
  
  final List<String> _weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  
  // Map of dates to events
  final Map<DateTime, List<Map<String, dynamic>>> _eventsByDate = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calendarController = ScrollController();
    _eventsController = PageController();
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
    
    // Initialize events data
    _initializeEvents();

    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  void _initializeEvents() {
    final now = DateTime.now();
    // Add events for the next 7 days
    for (int i = -3; i <= 3; i++) {
      final date = DateTime(now.year, now.month, now.day + i);
      if (i == 0) {
        _eventsByDate[date] = [
          {
            'time': '09:00 - 11:00',
            'title': "Sunday Service",
            'location': 'Kingdom Church Main hall',
            'hasLiveStream': true,
          },
          {
            'time': '14:00 - 16:00',
            'title': 'Youth Service',
            'location': 'Kingdom Church Youth Center',
            'hasLiveStream': false,
          },
          {
            'time': '17:00 - 18:30',
            'title': 'Evening Prayer',
            'location': 'Kingdom Church Chapel',
            'hasLiveStream': true,
          },
        ];
      } else if (i == 1) {
        _eventsByDate[date] = [
          {
            'time': '18:00 - 20:00',
            'title': 'Bible Study',
            'location': 'Kingdom Church Main hall',
            'hasLiveStream': true,
          },
          {
            'time': '15:00 - 16:30',
            'title': 'Choir Practice',
            'location': 'Kingdom Church Choir Room',
            'hasLiveStream': false,
          },
        ];
      } else if (i == 2) {
        _eventsByDate[date] = [
          {
            'time': '19:00 - 21:00',
            'title': 'Midweek Service',
            'location': 'Kingdom Church Main hall',
            'hasLiveStream': true,
          },
        ];
      } else {
        _eventsByDate[date] = [];
      }
    }
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    
    // Animate events list
    _eventsController.animateToPage(
      date.difference(DateTime.now()).inDays + 3,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _calendarController.dispose();
    _eventsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final now = DateTime.now();
    return Container(
      color: theme.primaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header for status bar only
          Container(
            color: Colors.transparent,
            child: SafeArea(
              bottom: false,
              child: Container(height: 0),
            ),
          ),
          
          // Video Player
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: YoutubePlayer(
                  controller: _youtubeController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: AppTheme.primary,
                  progressColors: ProgressBarColors(
                    playedColor: AppTheme.primary,
                    handleColor: AppTheme.secondary,
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
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
            ],
          ),
          
          // Calendar Strip
          Container(
            height: 90,
            padding: EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              controller: _calendarController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index - 3));
                final isSelected = date.day == _selectedDate.day;
                final isToday = date.day == now.day && 
                              date.month == now.month && 
                              date.year == now.year;
                final hasEvents = (_eventsByDate[date]?.isNotEmpty ?? false);
                
                return GestureDetector(
                  onTap: () => _selectDate(date),
                  child: Container(
                    width: 55,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _weekDays[date.weekday % 7],
                          style: GoogleFonts.poppins(
                            color: isSelected ? AppTheme.primary : theme.secondaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? AppTheme.primary : (isToday ? Colors.transparent : null),
                            border: isToday && !isSelected ? Border.all(
                              color: AppTheme.primary,
                              width: 2,
                            ) : null,
                          ),
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: GoogleFonts.poppins(
                                color: isSelected ? Colors.white : (isToday ? AppTheme.primary : theme.primaryText),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        if (hasEvents)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Events List
          Expanded(
            child: PageView.builder(
              controller: _eventsController,
              onPageChanged: (index) {
                _selectDate(DateTime.now().add(Duration(days: index - 3)));
              },
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().add(Duration(days: index - 3));
                final events = _eventsByDate[date] ?? [];
                
                if (events.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 48,
                          color: theme.secondaryText.withOpacity(0.5),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No events scheduled',
                          style: GoogleFonts.poppins(
                            color: theme.secondaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (event['hasLiveStream'] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Switching to live stream...'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      event['time'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (event['hasLiveStream'] == true) ...[
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.live_tv,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'LIVE',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  event['title'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      event['location'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
