import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'listconfig_model.dart';
export 'listconfig_model.dart';

/// List of user last acitvities
class ListconfigWidget extends StatefulWidget {
  const ListconfigWidget({super.key});

  static String routeName = 'listconfig';
  static String routePath = '/listconfig';

  @override
  State<ListconfigWidget> createState() => _ListconfigWidgetState();
}

class _ListconfigWidgetState extends State<ListconfigWidget> {
  late ListconfigModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListconfigModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                title: Text(
                  FFLocalizations.of(context).getText(
                    'r5705w0b' /* List Config */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineLargeFamily,
                        color: FlutterFlowTheme.of(context).tertiary,
                        fontSize: 30.0,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).headlineLargeIsCustom,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 0.0, 4.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'coh0kfga' /* Unit of Distance */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ),
                      FlutterFlowDropDown<String>(
                        controller: _model.distanceconfigValueController ??=
                            FormFieldController<String>(
                          _model.distanceconfigValue ??=
                              FFAppState().distanceUnit,
                        ),
                        options: [
                          FFLocalizations.of(context).getText(
                            'a0tol1dv' /* imperial */,
                          ),
                          FFLocalizations.of(context).getText(
                            '8k608ypr' /* metric */,
                          )
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.distanceconfigValue = val);
                          FFAppState().distanceUnit =
                              _model.distanceconfigValue!;
                          safeSetState(() {});
                        },
                        width: 325.54,
                        height: 40.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          'yccdixp5' /* Select... */,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor: FlutterFlowTheme.of(context).secondary,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 0.0, 4.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '3qz66l8r' /* Sort By */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ),
                      FlutterFlowDropDown<String>(
                        controller: _model.sortbyValueController ??=
                            FormFieldController<String>(null),
                        options: [
                          FFLocalizations.of(context).getText(
                            '15smxs97' /* name */,
                          ),
                          FFLocalizations.of(context).getText(
                            '6efcmd6w' /* distance */,
                          ),
                          FFLocalizations.of(context).getText(
                            '6tpczcee' /* value */,
                          )
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.sortbyValue = val);
                          FFAppState().sortBy = _model.sortbyValue!;
                          safeSetState(() {});
                        },
                        width: 326.62,
                        height: 40.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          '6ex1abhv' /* Select... */,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor: FlutterFlowTheme.of(context).secondary,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 0.0, 4.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'yz0zq76o' /* Order */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .labelMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .labelMediumIsCustom,
                              ),
                        ),
                      ),
                      FlutterFlowDropDown<String>(
                        controller: _model.orderValueController ??=
                            FormFieldController<String>(null),
                        options: [
                          FFLocalizations.of(context).getText(
                            'cqe8y6on' /* ascending */,
                          ),
                          FFLocalizations.of(context).getText(
                            'cgle5cy0' /* descending */,
                          )
                        ],
                        onChanged: (val) async {
                          safeSetState(() => _model.orderValue = val);
                          if (_model.orderValue == 'ascending') {
                            FFAppState().sorAscending = true;
                            safeSetState(() {});
                          } else {
                            FFAppState().sorAscending = false;
                            safeSetState(() {});
                          }
                        },
                        width: 326.6,
                        height: 40.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodyMediumIsCustom,
                            ),
                        hintText: FFLocalizations.of(context).getText(
                          'rz37kdse' /* Select... */,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor: FlutterFlowTheme.of(context).secondary,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
