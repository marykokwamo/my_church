import 'package:flutter/material.dart';
// ignore: unused_import
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class MyEventsQRWidget extends StatefulWidget {
  const MyEventsQRWidget({Key? key}) : super(key: key);

  @override
  _MyEventsQRWidgetState createState() => _MyEventsQRWidgetState();
}

class _MyEventsQRWidgetState extends State<MyEventsQRWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Events QR',
        showBackButton: true,
      ),
      body: Center(
        child: Text('My Events QR Coming Soon'),
      ),
    );
  }
}
