import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sermons_model.dart';
export 'sermons_model.dart';

class SermonsWidget extends StatefulWidget {
  const SermonsWidget({super.key});

  @override
  State<SermonsWidget> createState() => _SermonsWidgetState();
}

class _SermonsWidgetState extends State<SermonsWidget> {
  late SermonsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedCategory = 'All';

  final List<SermonItem> sermons = [
    SermonItem(
      title: 'How Shall This Be',
      preacher: 'Pastor John Doe',
      date: '2024-12-15',
      duration: '45:30',
      category: 'Doctrine',
      thumbnailUrl: 'assets/images/sermon1.png',
      videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID_1',
    ),
    SermonItem(
      title: 'How Shall This Be',
      preacher: 'Pastor Jane Smith',
      date: '2024-12-15',
      duration: '38:15',
      category: 'Doctrine',
      thumbnailUrl: 'assets/images/sermon2.png',
      videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID_2',
    ),
    SermonItem(
      title: 'How Shall This Be',
      preacher: 'Pastor John Doe',
      date: '2024-12-15',
      duration: '42:00',
      category: 'Doctrine',
      thumbnailUrl: 'assets/images/sermon3.png',
      videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID_3',
    ),
    SermonItem(
      title: 'How Shall This Be',
      preacher: 'Pastor Jane Smith',
      date: '2024-12-15',
      duration: '35:45',
      category: 'Doctrine',
      thumbnailUrl: 'assets/images/sermon4.png',
      videoUrl: 'https://www.youtube.com/watch?v=VIDEO_ID_4',
    ),
  ];

  final List<String> categories = [
    'All',
    'Doctrine',
    'Faith',
    'Prayer',
    'Worship',
    'Leadership',
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SermonsModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.primary,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.church,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Sermons',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Filter By Category',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        style: GoogleFonts.poppins(
                          color: theme.primaryText,
                          fontSize: 14,
                        ),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(
                              category,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sermons Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: sermons.length,
                      itemBuilder: (context, index) {
                        final sermon = sermons[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  sermon.thumbnailUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sermon.title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: theme.primaryText,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        sermon.category,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: theme.primary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        sermon.date,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 24),

                    // Trending Sermons
                    Text(
                      'Trending Sermons',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 280,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage('assets/images/new_life.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Text(
                                    'New Life in Christ',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SermonItem {
  final String title;
  final String preacher;
  final String date;
  final String duration;
  final String category;
  final String thumbnailUrl;
  final String videoUrl;

  SermonItem({
    required this.title,
    required this.preacher,
    required this.date,
    required this.duration,
    required this.category,
    required this.thumbnailUrl,
    required this.videoUrl,
  });
}
