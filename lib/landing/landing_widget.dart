import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../widgets/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../shop/shop_widget.dart';
import '../providers/cart_provider.dart';
import 'landing_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../models/cart_item.dart';
export 'landing_model.dart';

class LandingWidget extends StatefulWidget {
  const LandingWidget({super.key});

  @override
  State<LandingWidget> createState() => _LandingWidgetState();
}

class _LandingWidgetState extends State<LandingWidget> {
  late LandingModel _model;
  late YoutubePlayerController _youtubeController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: CustomAppBar(
        title: 'Home',
        showDrawerButton: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primary,
                        FlutterFlowTheme.of(context).secondary
                      ],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 40.0, 16.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlutterFlowIconButton(
                              borderRadius: 20.0,
                              buttonSize: 40.0,
                              fillColor: Color(0x33FFFFFF),
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              onPressed: () {
                                if (_scaffoldKey.currentState!.isDrawerOpen) {
                                  _scaffoldKey.currentState!.closeDrawer();
                                } else {
                                  _scaffoldKey.currentState!.openDrawer();
                                }
                              },
                            ),
                            Text(
                              'Home',
                              style: GoogleFonts.poppins(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 40), // Balance the layout
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Bitwise,',
                        style: GoogleFonts.poppins(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      Text(
                        'Welcome to Bitwise Church',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // YouTube Video Section
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 250,
                        child: YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Trending Sermons Carousel
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Trending Sermons',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                        ),
                        items: sermonSlides.map((item) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(item),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(40),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Shop Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shop',
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopWidget(),
                            ),
                          );
                        },
                        child: Text(
                          'View Shop',
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            color: Color(0xFFE31E24),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shopItems.length,
                    itemBuilder: (context, index) {
                      final item = shopItems[index];
                      return Container(
                        width: 200,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 16 : 8,
                          right: index == shopItems.length - 1 ? 16 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.asset(
                                item['image'] as String,
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Product Details
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Title
                                    Text(
                                      item['title'] as String,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    // Price
                                    Text(
                                      'Ksh ${item['price']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.0,
                                        color: Color(0xFFE31E24),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    // Add to Cart Button
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final cartProvider = Provider.of<CartProvider>(context, listen: false);
                                          final cartItem = CartItem(
                                            id: item['id'],
                                            title: item['title'],
                                            price: double.parse(item['price'].toString()),
                                            image: item['image'],
                                            author: item['author'] ?? '',
                                          );
                                          cartProvider.addItem(cartItem);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Added to cart'),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Color(0xFFE31E24),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFE31E24),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                        ),
                                        child: Text(
                                          'Add to Cart',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
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
                ),
                SizedBox(height: 20),

                // Upcoming Events Section
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        offset: Offset(0, 2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/upcomingevents.jpg',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Upcoming Events',
                          style: GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
