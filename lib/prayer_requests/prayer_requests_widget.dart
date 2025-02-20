import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class PrayerRequestsWidget extends StatefulWidget {
  const PrayerRequestsWidget({Key? key}) : super(key: key);

  @override
  _PrayerRequestsWidgetState createState() => _PrayerRequestsWidgetState();
}

class _PrayerRequestsWidgetState extends State<PrayerRequestsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Prayer Requests',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Prayer Requests Coming Soon'),
      ),
    );
  }
}
