import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'change_language_model.dart';
export 'change_language_model.dart';

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({super.key});

  static String routeName = 'changeLanguage';
  static String routePath = '/changeLanguage';

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  late ChangeLanguageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangeLanguageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  FFLocalizations.of(context).getText(
                    'pmdgtp2d' /* Languages */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        color: Colors.white,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context)
                            .headlineMediumIsCustom,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    setAppLanguage(context, 'en');
                    context.safePop();
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        FFLocalizations.of(context).getText(
                          'fg21etlx' /* English */,
                        ),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleLargeIsCustom,
                            ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0x5257636C),
                        size: 24.0,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 16.0, 12.0, 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    setAppLanguage(context, 'es');
                    context.safePop();
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        FFLocalizations.of(context).getText(
                          'bh84sjbk' /* Spanish */,
                        ),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleLargeIsCustom,
                            ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0x5257636C),
                        size: 24.0,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 12.0, 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    setAppLanguage(context, 'fr');
                    context.safePop();
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        FFLocalizations.of(context).getText(
                          '63mya96y' /* French */,
                        ),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleLargeFamily,
                              letterSpacing: 0.0,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .titleLargeIsCustom,
                            ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0x5257636C),
                        size: 24.0,
                      ),
                      tileColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      dense: false,
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 6.0, 12.0, 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
