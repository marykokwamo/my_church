import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'jobfilter_model.dart';
export 'jobfilter_model.dart';

class JobfilterWidget extends StatefulWidget {
  const JobfilterWidget({super.key});

  @override
  State<JobfilterWidget> createState() => _JobfilterWidgetState();
}

class _JobfilterWidgetState extends State<JobfilterWidget> {
  late JobfilterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JobfilterModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
