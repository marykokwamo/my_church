import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';

/// MyChurch Design System
class MyChurchTheme {
  // Layout Constants
  static const double containerHeightFactor = 0.75;
  static const double topContainerRadius = 25.0;
  static const double standardRadius = 12.0;
  static const double standardPadding = 32.0;
  static const double topContentPadding = 40.0;

  // Typography Sizes
  static const double headingSize = 28.0;
  static const double bodySize = 16.0;
  static const double buttonTextSize = 16.0;
  static const double inputTextSize = 16.0;
  static const double letterSpacing = 0.5;
  static const double lineHeight = 1.5;

  // Spacing
  static const double majorSectionSpacing = 32.0;
  static const double relatedElementSpacing = 16.0;
  static const EdgeInsetsDirectional inputFieldPadding =
      EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16);
  static const double buttonHeight = 50.0;

  // Logo
  static const double logoWidthFactor = 0.65;

  // Shadows
  static BoxShadow get containerShadow => BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, -2),
      );

  static BoxShadow get inputFieldShadow => BoxShadow(
        color: Colors.black.withOpacity(0.05),
        spreadRadius: 0,
        blurRadius: 4,
        offset: Offset(0, 2),
      );

  // Button Properties
  static const double buttonElevation = 3.0;
  static const double buttonHoverElevation = 4.0;

  // Input Field Properties
  static const double inputBorderWidth = 1.0;
  static const double inputFocusedBorderWidth = 2.0;

  // Helper Methods
  static InputDecoration getInputDecoration(
    BuildContext context, {
    required String labelText,
    String? hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.5),
            fontSize: inputTextSize,
            letterSpacing: letterSpacing,
          ),
      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
            color: FlutterFlowTheme.of(context).secondaryText.withOpacity(0.3),
            fontSize: inputTextSize,
            letterSpacing: letterSpacing,
            useGoogleFonts: GoogleFonts.asMap()
                .containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
          ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          width: inputBorderWidth,
        ),
        borderRadius: BorderRadius.circular(standardRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primary,
          width: inputFocusedBorderWidth,
        ),
        borderRadius: BorderRadius.circular(standardRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).error,
          width: inputBorderWidth,
        ),
        borderRadius: BorderRadius.circular(standardRadius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).error,
          width: inputFocusedBorderWidth,
        ),
        borderRadius: BorderRadius.circular(standardRadius),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
      contentPadding: inputFieldPadding,
    );
  }

  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topContainerRadius),
        topRight: Radius.circular(topContainerRadius),
      ),
      boxShadow: [containerShadow],
    );
  }

  static BoxDecoration getInputContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.circular(standardRadius),
      boxShadow: [inputFieldShadow],
    );
  }
}
