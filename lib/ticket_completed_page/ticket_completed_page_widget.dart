import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'ticket_completed_page_model.dart';
export 'ticket_completed_page_model.dart';

class TicketCompletedPageWidget extends StatefulWidget {
  const TicketCompletedPageWidget({super.key});

  static String routeName = 'ticketCompletedPage';
  static String routePath = '/ticketCompletedPage';

  @override
  State<TicketCompletedPageWidget> createState() =>
      _TicketCompletedPageWidgetState();
}

class _TicketCompletedPageWidgetState extends State<TicketCompletedPageWidget> {
  late TicketCompletedPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketCompletedPageModel());

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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 285.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      Color(0xFF0018DE)
                    ],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(1.0, 1.0),
                    end: AlignmentDirectional(-1.0, -1.0),
                  ),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: FlutterFlowTheme.of(context).info,
                        size: 60.0,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'u4742u1p' /* Thank You! */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).info,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'lxuctswy' /* Your vallet has been successfu... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color: FlutterFlowTheme.of(context).info,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyMediumIsCustom,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 32.0, 24.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '6hu6n5jo' /* Valet Details */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleLargeFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleLargeIsCustom,
                              ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x19000000),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'uwnm9p6y' /* Ticket #A12345 */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .titleMediumFamily,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .titleMediumIsCustom,
                                          ),
                                    ),
                                    Container(
                                      width: 80.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 4.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'h6sgd31x' /* Completed */,
                                          ),
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    !FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmallIsCustom,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 4.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'sy8xzymd' /* Date Submitted */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'gguyw9t7' /* October 15, 2023 */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 4.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'qwllrxdd' /* Date Completed */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'edfpbs2t' /* October 18, 2023 */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 4.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'xkw1gh1z' /* Category */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'ird7vz36' /* Technical Support */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 4.0),
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '4elh7u9q' /* Priority */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    useGoogleFonts:
                                                        !FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmallIsCustom,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'xp10tnf0' /* Medium */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  useGoogleFonts:
                                                      !FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumIsCustom,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'p1woxeq9' /* Description */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodySmallFamily,
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodySmallIsCustom,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'a7itdiqb' /* Login authentication issue wit... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'n10gq1gx' /* Resolution */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodySmallFamily,
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodySmallIsCustom,
                                      ),
                                ),
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  '1ovuyv0w' /* Reset user authentication toke... */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts:
                                          !FlutterFlowTheme.of(context)
                                              .bodyMediumIsCustom,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 12.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '4jxrjxda' /* Site detail */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x19000000),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      '500x500?person',
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        '24rcl2v1' /* Sarah Johnson */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLargeFamily,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyLargeIsCustom,
                                          ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'mwp4ecmk' /* Technical Support Specialist */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 32.0, 24.0, 32.0),
                child: Container(
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: FFLocalizations.of(context).getText(
                      's4ih0v2r' /* Return to Dashboard */,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsets.all(0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .titleSmallIsCustom,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
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
