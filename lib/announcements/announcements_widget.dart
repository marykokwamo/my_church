import 'package:flutter/material.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class AnnouncementsWidget extends StatefulWidget {
  const AnnouncementsWidget({Key? key}) : super(key: key);

  @override
  _AnnouncementsWidgetState createState() => _AnnouncementsWidgetState();
}

class _AnnouncementsWidgetState extends State<AnnouncementsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Announcements',
        showBackButton: true,
      ),
      body: Center(
        child: Text(
          'Announcements Coming Soon',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      ),
    );
  }
}
