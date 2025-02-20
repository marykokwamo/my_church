import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class CheckinWidget extends StatefulWidget {
  const CheckinWidget({Key? key}) : super(key: key);

  @override
  _CheckinWidgetState createState() => _CheckinWidgetState();
}

class _CheckinWidgetState extends State<CheckinWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Check In',
        showBackButton: true,
      ),
      body: Center(
        child: Text('Check-in Coming Soon'),
      ),
    );
  }
}
