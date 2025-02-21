import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../utils/error_handler.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final bool overlay;

  const LoadingWidget({
    Key? key,
    this.message,
    this.overlay = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: FlutterFlowTheme.of(context).bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );

    if (overlay) {
      return Container(
        color: Colors.black54,
        child: content,
      );
    }

    return content;
  }
}

class AsyncWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) builder;
  final Widget? loadingWidget;
  final Widget Function(String error)? errorBuilder;

  const AsyncWidget({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorBuilder?.call(snapshot.error.toString()) ??
              ErrorHandler.errorWidget(
                snapshot.error.toString(),
                () {
                  // Rebuild the widget
                  (context as Element).markNeedsBuild();
                },
              );
        }

        if (!snapshot.hasData) {
          return loadingWidget ?? const LoadingWidget();
        }

        return builder(snapshot.data as T);
      },
    );
  }
}
