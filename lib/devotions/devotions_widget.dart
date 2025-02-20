import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class DevotionsWidget extends StatefulWidget {
  const DevotionsWidget({Key? key}) : super(key: key);

  @override
  _DevotionsWidgetState createState() => _DevotionsWidgetState();
}

class _DevotionsWidgetState extends State<DevotionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Devotions',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Daily Devotions Coming Soon'),
      ),
    );
  }
}
