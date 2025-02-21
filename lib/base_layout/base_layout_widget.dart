// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../landing/landing_widget.dart';
import '../sermons/sermons_widget.dart';
import '../live_tv/live_tv_widget.dart';
import '../give/give_widget.dart';
import '../widgets/custom_app_bar.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_util.dart';
import '../design_system/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseLayoutWidget extends StatefulWidget {
  final int initialIndex;
  final bool showAppBar;

  const BaseLayoutWidget({
    Key? key,
    this.initialIndex = 0,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  _BaseLayoutWidgetState createState() => _BaseLayoutWidgetState();
}

class _BaseLayoutWidgetState extends State<BaseLayoutWidget> {
  late int _currentIndex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    LandingWidget(),
    GiveWidget(),
    SermonsWidget(),
    LiveTVWidget(),
  ];

  final List<String> _titles = [
    'Home',
    'Give',
    'Sermons',
    'Live TV',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        showBackButton: false,
        showDrawerButton: true,
        scaffoldKey: _scaffoldKey,
        notificationCount: 3,
      ),
      drawer: _buildDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.primary,
          selectedItemColor: AppTheme.secondary,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism),
              label: 'Give',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Sermons',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: 'Live TV',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header with back arrow
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black87,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 8),
                children: [
                  _buildDrawerItem(
                    iconPath: 'assets/icons/checkin.svg',
                    title: 'Checkin',
                    onTap: () {
                      context.pop();
                      context.go('/checkin');
                    },
                  ),
                  _buildDrawerItem(
                    iconPath: 'assets/icons/prayer_requests.svg',
                    title: 'Prayer Requests',
                    onTap: () {
                      context.pop();
                      context.go('/prayer-requests');
                    },
                  ),
                  _buildDrawerItem(
                    iconPath: 'assets/icons/devotions.svg',
                    title: 'Devotions',
                    onTap: () {
                      context.pop();
                      context.go('/devotions');
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  _buildDrawerItem(
                    iconPath: 'assets/icons/events_calendar.svg',
                    title: 'Events Calendar',
                    onTap: () {
                      context.pop();
                      context.go('/events-calendar');
                    },
                  ),
                  _buildDrawerItem(
                    iconPath: 'assets/icons/my_events_qr.svg',
                    title: 'My Events QR',
                    onTap: () {
                      context.pop();
                      context.go('/my-events-qr');
                    },
                  ),
                  _buildDrawerItem(
                    iconPath: 'assets/icons/shop.svg',
                    title: 'Shop',
                    onTap: () {
                      context.pop();
                      context.go('/shop');
                    },
                  ),
                  _buildDrawerItem(
                    iconPath: 'assets/icons/announcements.svg',
                    title: 'Announcements',
                    onTap: () {
                      context.pop();
                      context.go('/announcements');
                    },
                  ),
                ],
              ),
            ),
            
            // Logo at bottom
            Padding(
              padding: EdgeInsets.all(24),
              child: Image.asset(
                'assets/images/MyChurch -logo color.png', // You can replace this with SVG when ready
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
