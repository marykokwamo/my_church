import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'chooseachurch_model.dart';
export 'chooseachurch_model.dart';

class ChooseachurchWidget extends StatefulWidget {
  const ChooseachurchWidget({super.key});

  @override
  State<ChooseachurchWidget> createState() => _ChooseachurchWidgetState();
}

class _ChooseachurchWidgetState extends State<ChooseachurchWidget> {
  late ChooseachurchModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseachurchModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {
          _model.textController?.text = 'Password';
        }));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(30.0, 40.0, 30.0, 0.0),
                                  child: Text(
                                    'Welcome!',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context).displaySmall.override(
                                          fontFamily: FlutterFlowTheme.of(context).displaySmallFamily,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(FlutterFlowTheme.of(context).displaySmallFamily),
                                        ),
                                  ),
                                ),
                              ).animate(
                                effects: [
                                  FadeEffect(
                                    duration: const Duration(milliseconds: 600),
                                  ),
                                  MoveEffect(
                                    begin: const Offset(0, 20),
                                    end: const Offset(0, 0),
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOut,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
                                  child: Text(
                                    'Select your church to continue.',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ),
                              ).animate(
                                effects: [
                                  FadeEffect(
                                    delay: const Duration(milliseconds: 200),
                                    duration: const Duration(milliseconds: 600),
                                  ),
                                  MoveEffect(
                                    delay: const Duration(milliseconds: 200),
                                    begin: const Offset(0, 20),
                                    end: const Offset(0, 0),
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOut,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(30.0, 40.0, 30.0, 20.0),
                                child: FlutterFlowDropDown<String>(
                                  controller: _model.dropDownValueController ??= FormFieldController<String>(null),
                                  options: ['Option 1'],
                                  onChanged: (val) => setState(() => _model.dropDownValue = val),
                                  width: MediaQuery.sizeOf(context).width * 0.85,
                                  height: 50.0,
                                  textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                  hintText: 'Select Church',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  elevation: 2.0,
                                  borderColor: FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 2.0,
                                  borderRadius: 8.0,
                                  margin: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                ).animate(
                                  effects: [
                                    FadeEffect(
                                      delay: const Duration(milliseconds: 400),
                                      duration: const Duration(milliseconds: 600),
                                    ),
                                    MoveEffect(
                                      delay: const Duration(milliseconds: 400),
                                      begin: const Offset(0, 20),
                                      end: const Offset(0, 0),
                                      duration: const Duration(milliseconds: 600),
                                      curve: Curves.easeOut,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 20.0),
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF494949),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                  validator: _model.textControllerValidator.asValidator(context),
                                ),
                              ).animate(
                                effects: [
                                  FadeEffect(
                                    delay: const Duration(milliseconds: 600),
                                    duration: const Duration(milliseconds: 600),
                                  ),
                                  MoveEffect(
                                    delay: const Duration(milliseconds: 600),
                                    begin: const Offset(0, 20),
                                    end: const Offset(0, 0),
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOut,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 20.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('HomePage');
                                  },
                                  text: 'Continue',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 50.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ).animate(
                                effects: [
                                  FadeEffect(
                                    delay: const Duration(milliseconds: 800),
                                    duration: const Duration(milliseconds: 600),
                                  ),
                                  MoveEffect(
                                    delay: const Duration(milliseconds: 800),
                                    begin: const Offset(0, 20),
                                    end: const Offset(0, 0),
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeOut,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
