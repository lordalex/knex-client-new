import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_client/api_client.dart';
import '/components/tip_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ticket_timer_model.dart';
export 'ticket_timer_model.dart';

/// current user ticket
class TicketTimerWidget extends StatefulWidget {
  const TicketTimerWidget({super.key});

  static String routeName = 'TicketTimer';
  static String routePath = '/ticketTimer';

  @override
  State<TicketTimerWidget> createState() => _TicketTimerWidgetState();
}

class _TicketTimerWidgetState extends State<TicketTimerWidget>
    with TickerProviderStateMixin {
  late TicketTimerModel _model;
  late ApiClient apiClient;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketTimerModel());

    apiClient = ApiClient();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
      _model.instantTimerTicket = InstantTimer.periodic(
        duration: Duration(milliseconds: 9500),
        callback: (timer) async {
          try {
            // final pinResponse = await apiClient.get... // No equivalent for getPINURL
            final latestTicket = await apiClient.getLatestTicket();
            if (latestTicket != null) {
              _model.laestTicketData = jsonEncode(latestTicket.toMap());
              safeSetState(() {});
              if (latestTicket.status != 'Processing-Departure') {
                context.pushNamed(TicketWidget.routeName);
                _model.instantTimerTicket?.cancel();
                return;
              }
            }
          } catch (e) {
            print(e);
            if (e.toString().contains('401')) {
              context.pushNamed(LoginSignUpWidget.routeName);
              _model.instantTimerTicket?.cancel();
              return;
            }
          }
        },
        startImmediately: true,
      );
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'rowOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 4500.0.ms,
            duration: 1430.0.ms,
            color: FlutterFlowTheme.of(context).secondary,
            angle: 0.524,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 1400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      _model.instantTimerTicket?.cancel();
    }();

    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primary,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primary,
                  Color(0xFF00055A)
                ],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 80.0),
              child: Container(
                height: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 16.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(),
                                    child: Visibility(
                                      visible: _model.pint != null &&
                                          _model.pint != '',
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (_model.pint != null &&
                                                _model.pint != '')
                                              Text(
                                                functions.tostr(_model.pint!),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontSize: 37.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumIsCustom,
                                                    ),
                                              ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child:
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      borderRadius: 25.0,
                                                      borderWidth: 0.0,
                                                      buttonSize: 35.0,
                                                      fillColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      icon: Icon(
                                                        Icons.replay,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                      onPressed: () async {
                                                        await Future.wait([
                                                          Future(() async {
                                                            _model.responsePrManual =
                                                                await actions
                                                                    .sendjsontourl(
                                                              '{\"searchCriteria\": {\"email\":  \"${currentUserEmail}\"}}',
                                                              currentJwtToken,
                                                              FFAppConstants
                                                                  .getPINURL,
                                                            );
                                                            if (_model
                                                                    .responsePrManual ==
                                                                '401') {
                                                              context.pushNamed(
                                                                  LoginSignUpWidget
                                                                      .routeName);
                                                            }
                                                            _model.pint = functions
                                                                .getkeyfromjsonstring(
                                                                    _model
                                                                        .responsePrManual!,
                                                                    'PIN');
                                                            safeSetState(() {});
                                                          }),
                                                        ]);

                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ),
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
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!(isWeb
                            ? MediaQuery.viewInsetsOf(context).bottom > 0
                            : _isKeyboardVisible))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                '5cfwqe1q' /* Pick your car */,
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .bodyMediumIsCustom,
                                  ),
                            ).animateOnPageLoad(
                                animationsMap['textOnPageLoadAnimation']!),
                          ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF8490F1),
                                  FlutterFlowTheme.of(context).primary
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0x43F1F4F8),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 5.0,
                                shape: const CircleBorder(),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 0.0,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: FlutterFlowTimer(
                                        initialTime: _model.timerInitialTimeMs,
                                        getDisplayTime: (value) =>
                                            StopWatchTimer.getDisplayTime(
                                          value,
                                          hours: false,
                                          milliSecond: false,
                                        ),
                                        controller: _model.timerController,
                                        updateStateInterval:
                                            Duration(milliseconds: 1000),
                                        onChanged:
                                            (value, displayTime, shouldUpdate) {
                                          _model.timerMilliseconds = value;
                                          _model.timerValue = displayTime;
                                          if (shouldUpdate) safeSetState(() {});
                                        },
                                        onEnded: () async {
                                          _model.timerEnded = true;
                                          safeSetState(() {});
                                        },
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              font: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 48.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.timerController.onStopTimer();
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: TipBottomSheetWidget(
                                        ticketNumber:
                                            functions.getkeyfromjsonstring(
                                                _model.laestTicketData,
                                                'ticket_number'),
                                        value: functions.tostr(
                                            functions.getkeyfromjsonstring(
                                                _model.laestTicketData,
                                                'value')),
                                        tipProposal: functions
                                            .stringToArrayInteger(
                                                functions.getkeyfromjsonstring(
                                                    functions
                                                        .getkeyfromjsonstring(
                                                            _model
                                                                .laestTicketData,
                                                            'site'),
                                                    'tip_proposal')),
                                        currencyType:
                                            functions.getkeyfromjsonstring(
                                                functions.getkeyfromjsonstring(
                                                    _model.laestTicketData,
                                                    'site'),
                                                'currency'),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Container(
                              width: 226.59,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).info,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 10.0, 12.0, 10.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '0ghljhzd' /* Pay vallet parking */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: Colors.black,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts:
                                                !FlutterFlowTheme.of(context)
                                                    .bodyMediumIsCustom,
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xD41F2B8F),
                                    size: 24.0,
                                  ),
                                ],
                              ).animateOnPageLoad(
                                  animationsMap['rowOnPageLoadAnimation']!),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation1']!),
                        ),
                        if (_model.timerEnded)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0x39F1F4F8),
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).info,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 8.0, 12.0, 8.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'mirofhmx' /* Attendant did not appear? */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .bodyMediumIsCustom,
                                      ),
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation2']!),
                          ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 12.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/vallet_one.png',
                                  width: 100.6,
                                  height: 49.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'cou1vpcs' /* Powered by KNEX */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyMediumFamily,
                                  color: Color(0xCCF1F4F8),
                                  fontSize: 11.4,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
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
          ),
        ),
      ),
    );
  }
}
