import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

void handleBackPress(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  } else {
    context.goNamed('HomePage');
  }
}
