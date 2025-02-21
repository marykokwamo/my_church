import 'package:flutter/material.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class EventsCalendarWidget extends StatefulWidget {
  const EventsCalendarWidget({Key? key}) : super(key: key);

  @override
  _EventsCalendarWidgetState createState() => _EventsCalendarWidgetState();
}

class _EventsCalendarWidgetState extends State<EventsCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Events Calendar',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Events Calendar Coming Soon'),
      ),
    );
  }
}
