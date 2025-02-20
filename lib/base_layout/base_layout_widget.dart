// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../landing/landing_widget.dart';
import '../sermons/sermons_widget.dart';
import '../live_tv/live_tv_widget.dart';
import '../give/give_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../design_system/app_theme.dart';

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
      appBar: widget.showAppBar && _currentIndex != 0 
          ? CustomAppBar(
              title: _titles[_currentIndex],
              showBackButton: false,
              showDrawerButton: true,
              scaffoldKey: _scaffoldKey,
              notificationCount: 3,
            )
          : null,
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
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MENU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.live_tv),
                  title: Text('Live TV'),
                  onTap: () {
                    Navigator.pushNamed(context, '/live-tv');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.video_library),
                  title: Text('Sermons'),
                  onTap: () {
                    Navigator.pushNamed(context, '/sermons');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Events'),
                  onTap: () {
                    Navigator.pushNamed(context, '/events');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Devotions'),
                  onTap: () {
                    Navigator.pushNamed(context, '/devotions');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Shop'),
                  onTap: () {
                    Navigator.pushNamed(context, '/shop');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/MyChurch -logo color.png',
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
