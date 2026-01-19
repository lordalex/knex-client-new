import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_client/api_client.dart';
import '/components/success_ticket_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'ticket_model.dart';
export 'ticket_model.dart';

/// current user ticket
class TicketWidget extends StatefulWidget {
  const TicketWidget({super.key});

  static String routeName = 'Ticket';
  static String routePath = '/ticket';

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget>
    with TickerProviderStateMixin {
  late TicketModel _model;
  late ApiClient apiClient;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TicketModel());

    apiClient = ApiClient();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Early check: Fetch ticket immediately and redirect if none exists
      try {
        final latestTicket = await apiClient.getLatestTicket();
        if (latestTicket == null ||
            latestTicket.status == 'Cancelled' ||
            latestTicket.status == 'Completed') {
          print(
              "ℹ️ [TicketWidget] No active ticket found, redirecting to HomePage");
          if (mounted) {
            context.goNamed(HomePageWidget.routeName);
          }
          return;
        }
        // Store the ticket data for use in build
        _model.latestTicketData = jsonEncode(latestTicket.toMap());
        safeSetState(() {});
      } catch (e) {
        print("⚠️ [TicketWidget] Error fetching initial ticket: $e");
        if (e.toString().contains('401')) {
          if (mounted) context.goNamed(LoginSignUpWidget.routeName);
          return;
        }
        // No ticket or error, redirect home
        if (mounted) context.goNamed(HomePageWidget.routeName);
        return;
      }

      await Future.wait([
        Future(() async {
          _model.instantTimer = InstantTimer.periodic(
            duration: Duration(milliseconds: 10000),
            callback: (timer) async {
              FFAppState().update(() {});
              try {
                final latestTicket = await apiClient.getLatestTicket();
                if (latestTicket != null) {
                  _model.latestTicketData = jsonEncode(latestTicket.toMap());
                  safeSetState(() {});

                  if (latestTicket.status == 'Completed') {
                    _model.instantTimer2?.cancel();
                    _model.instantTimer?.cancel();
                    HapticFeedback.heavyImpact();
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(dialogContext).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: SuccessTicketWidget(
                              ticketNumber: latestTicket.ticketNumber,
                              name: 'Trulucks',
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  } else if (latestTicket.status == 'Processing-Departure') {
                    _model.instantTimer?.cancel();
                    _model.instantTimer2?.cancel();
                    context.pushNamed(TicketTimerWidget.routeName);
                    return;
                  } else if (latestTicket.status != 'Cancelled') {
                    // _model.accepted = latestTicket.accepted == 'true'; // accepted not in model
                    safeSetState(() {});
                  }
                } else {
                  _model.instantTimer?.cancel();
                  _model.instantTimer2?.cancel();
                  context.pushNamed(HomePageWidget.routeName);
                  return;
                }
              } catch (e) {
                print(e);
                if (e.toString().contains('401')) {
                  _model.instantTimer?.cancel();
                  _model.instantTimer2?.cancel();
                  context.pushNamed(LoginSignUpWidget.routeName);
                }
              }
            },
            startImmediately: true,
          );
        }),
        Future(() async {
          _model.instantTimer2 = InstantTimer.periodic(
            duration: Duration(milliseconds: 10000),
            callback: (timer) async {
              try {
                // There is no direct equivalent of getPINURL in the new API.
                // Assuming the PIN is part of the ticket data.
                // The logic for getting a separate PIN needs to be re-evaluated
                // based on the new API design.
                // For now, I will leave this part commented out.
                // final response = await apiClient.getTicketByPIN(pin);
                // _model.pint = response.pin;
                safeSetState(() {});
              } catch (e) {
                print(e);
                if (e.toString().contains('401')) {
                  _model.instantTimer2?.cancel();
                  context.pushNamed(LoginSignUpWidget.routeName);
                }
              }
            },
            startImmediately: true,
          );
        }),
      ]);
      _model.isPageLoaded = true;
      safeSetState(() {});
      while ((_model.doubleCurrentPorcentageLoader <= 1.0) && !kDebugMode) {
        _model.doubleCurrentPorcentageLoader =
            _model.doubleCurrentPorcentageLoader + 0.05;
        safeSetState(() {});
        await Future.delayed(
          Duration(
            milliseconds: 500,
          ),
        );
        if (_model.doubleCurrentPorcentageLoader >= 0.97) {
          _model.doubleCurrentPorcentageLoader = 0.0;
          safeSetState(() {});
        }
      }
    });

    animationsMap.addAll({
      'progressBarOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 880.0.ms,
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1340.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1340.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 120.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 120.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 120.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 240.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 240.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 240.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 70.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation1': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1780.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        loop: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1780.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1780.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'textOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1780.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
      'textOnPageLoadAnimation5': AnimationInfo(
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
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 600.ms),
          FadeEffect(
            curve: Curves.bounceOut,
            delay: 600.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.bounceOut,
            delay: 600.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.7, 0.7),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      _model.instantTimer?.cancel();
      _model.instantTimer2?.cancel();
      _model.instantTimer5?.cancel();
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: PopScope(
          canPop: false,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  if (_model.isPageLoaded == true)
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
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
                                        visible: (_model.accepted == false) &&
                                            (functions.tostr(functions
                                                    .getkeyfromjsonstring(
                                                        _model.latestTicketData,
                                                        'status')) !=
                                                'Completed'),
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
                                                  valueOrDefault<String>(
                                                    functions
                                                        .tostr(_model.pint!),
                                                    '000000',
                                                  ),
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
                                                                .primaryText,
                                                        fontSize: 38.0,
                                                        letterSpacing: 2.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts:
                                                            !FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMediumIsCustom,
                                                      ),
                                                ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      children: [
                                                        if (_model
                                                                .doubleCurrentPorcentageLoader <=
                                                            0.99)
                                                          CircularPercentIndicator(
                                                            percent: _model
                                                                .doubleCurrentPorcentageLoader,
                                                            radius: 21.5,
                                                            lineWidth: 20.0,
                                                            animation: true,
                                                            animateFromLastPercent:
                                                                true,
                                                            progressColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                          ).animateOnActionTrigger(
                                                            animationsMap[
                                                                'progressBarOnActionTriggerAnimation']!,
                                                          ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderColor: Color(
                                                                0x981F2B8F),
                                                            borderRadius: 25.0,
                                                            borderWidth: 0.0,
                                                            buttonSize: 35.0,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            icon: Icon(
                                                              Icons.replay,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 20.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // This functionality needs to be revisited based on the new API design.
                                                              // There is no direct equivalent for getting a PIN for a user.
                                                            },
                                                          ),
                                                        ),
                                                      ],
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
                          Stack(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 5.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 15.0, 0.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 4.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15.0),
                                              bottomRight:
                                                  Radius.circular(15.0),
                                              topLeft: Radius.circular(15.0),
                                              topRight: Radius.circular(15.0),
                                            ),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: valueOrDefault<Color>(
                                                _model.accepted
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12.0,
                                                  color: Color(0x13161616),
                                                  offset: Offset(
                                                    0.0,
                                                    5.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(15.0),
                                                bottomRight:
                                                    Radius.circular(15.0),
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              children: [
                                                if (loggedIn)
                                                  Opacity(
                                                    opacity: 0.1,
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    240.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? 'assets/images/vallet_one.png'
                                                                : 'assets/images/valletOneLogoblack.png',
                                                            width: 232.0,
                                                            height: 155.86,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    if (_model.isPageLoaded)
                                                      Container(
                                                        width: double.infinity,
                                                        height: 126.6,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    12.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    12.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      10.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: 180.5,
                                                            height: 200.0,
                                                            child:
                                                                CarouselSlider(
                                                              items: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/vallet_one.png',
                                                                    width:
                                                                        214.3,
                                                                    height:
                                                                        147.7,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/vallet_one.png',
                                                                    width:
                                                                        188.0,
                                                                    height:
                                                                        200.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/vallet_one.png',
                                                                    width:
                                                                        200.0,
                                                                    height:
                                                                        200.0,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ],
                                                              carouselController:
                                                                  _model.carouselController ??=
                                                                      CarouselSliderController(),
                                                              options:
                                                                  CarouselOptions(
                                                                initialPage: 1,
                                                                viewportFraction:
                                                                    1.0,
                                                                disableCenter:
                                                                    true,
                                                                enlargeCenterPage:
                                                                    true,
                                                                enlargeFactor:
                                                                    0.25,
                                                                enableInfiniteScroll:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                autoPlay: true,
                                                                autoPlayAnimationDuration:
                                                                    Duration(
                                                                        milliseconds:
                                                                            1000),
                                                                autoPlayInterval: Duration(
                                                                    milliseconds:
                                                                        (1000 +
                                                                            9000)),
                                                                autoPlayCurve:
                                                                    Curves
                                                                        .linear,
                                                                pauseAutoPlayInFiniteScroll:
                                                                    true,
                                                                onPageChanged: (index,
                                                                        _) =>
                                                                    _model.carouselCurrentIndex =
                                                                        index,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  16.0),
                                                      child: Container(
                                                        width: 100.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0.0),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          16.0,
                                                                          4.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        AutoSizeText(
                                                                      functions.tostr(functions.getkeyfromjsonstring(
                                                                          functions.getkeyfromjsonstring(
                                                                              _model.latestTicketData,
                                                                              'site'),
                                                                          'name')),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.interTight(
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            fontSize:
                                                                                22.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w800,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child:
                                                                  AutoSizeText(
                                                                functions.tostr(functions.getkeyfromjsonstring(
                                                                    functions.getkeyfromjsonstring(
                                                                        _model
                                                                            .latestTicketData,
                                                                        'site'),
                                                                    'address')),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .interTight(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                      fontSize:
                                                                          13.5,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          18.0,
                                                                          0.0,
                                                                          16.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          functions.tostr(functions.getkeyfromjsonstring(
                                                                              functions.extractTime(functions.getkeyfromjsonstring(_model.latestTicketData, 'created_at')),
                                                                              'time')),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.interTight(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                fontSize: 22.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            4.0,
                                                                            20.0,
                                                                            0.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          functions.tostr(functions.getkeyfromjsonstring(
                                                                              functions.extractTime(functions.getkeyfromjsonstring(_model.latestTicketData, 'created_at')),
                                                                              'date')),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                font: GoogleFonts.interTight(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                fontSize: 13.5,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ).animateOnPageLoad(
                                                                      animationsMap[
                                                                          'columnOnPageLoadAnimation1']!),
                                                                ),
                                                                if (functions
                                                                            .stringArrayToListString(functions.getkeyfromjsonstring(
                                                                                _model
                                                                                    .latestTicketData,
                                                                                'notes'))
                                                                            .firstOrNull !=
                                                                        null &&
                                                                    functions
                                                                            .stringArrayToListString(functions.getkeyfromjsonstring(_model.latestTicketData,
                                                                                'notes'))
                                                                            .firstOrNull !=
                                                                        '')
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.car_crash,
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                              size: 17.0,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  'hdu9wi1r' /* Client's Requests:  */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                      color: FlutterFlowTheme.of(context).info,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final queryNotes = functions
                                                                              .stringArrayToListString(functions.getkeyfromjsonstring(_model.latestTicketData, 'notes'))
                                                                              .toList()
                                                                              .take(3)
                                                                              .toList();

                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                List.generate(queryNotes.length, (queryNotesIndex) {
                                                                              final queryNotesItem = queryNotes[queryNotesIndex];
                                                                              return Container(
                                                                                width: 160.0,
                                                                                height: 21.06,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(16.0),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      FaIcon(
                                                                                        FontAwesomeIcons.exclamation,
                                                                                        color: Color(0xB3F1F4F8),
                                                                                        size: 6.0,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          functions.tostr(queryNotesItem),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                                color: FlutterFlowTheme.of(context).info,
                                                                                                fontSize: 12.5,
                                                                                                letterSpacing: 0.0,
                                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (loggedIn)
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -0.85,
                                                                        -0.15),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      0.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              50.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              50.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 50.0,
                                                                    height:
                                                                        60.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x17737373),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(0.0),
                                                                        bottomRight:
                                                                            Radius.circular(50.0),
                                                                        topLeft:
                                                                            Radius.circular(0.0),
                                                                        topRight:
                                                                            Radius.circular(50.0),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 0.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 40.0,
                                                                  height: 7.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x17737373),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                  ),
                                                                ),
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 0.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 40.0,
                                                                  height: 7.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x17737373),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                  ),
                                                                ),
                                                              ),
                                                              Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 0.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4.0),
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: 40.0,
                                                                  height: 7.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0x17737373),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.85,
                                                                        -0.15),
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      0.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              50.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              50.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              0.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: 50.0,
                                                                    height:
                                                                        60.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0x17737373),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(50.0),
                                                                        bottomRight:
                                                                            Radius.circular(0.0),
                                                                        topLeft:
                                                                            Radius.circular(50.0),
                                                                        topRight:
                                                                            Radius.circular(0.0),
                                                                      ),
                                                                      shape: BoxShape
                                                                          .rectangle,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      20.0,
                                                                      8.0,
                                                                      20.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    if (functions.tostr(functions.getkeyfromjsonstring(
                                                                            _model.latestTicketData,
                                                                            'status')) ==
                                                                        'Arrival')
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'xitg74nn' /* Valet has been notified */,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  font: GoogleFonts.interTight(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 23.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                ),
                                                                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                                                                        ),
                                                                      ),
                                                                    if ((functions.tostr(functions.getkeyfromjsonstring(_model.latestTicketData, 'status')) ==
                                                                            'Processing-Arrival') &&
                                                                        !_model
                                                                            .accepted)
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'rtyn7dqt' /* Wait your valet is coming */,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  font: GoogleFonts.interTight(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 23.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                ),
                                                                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
                                                                        ),
                                                                      ),
                                                                    if ((_model
                                                                                .accepted ==
                                                                            true) &&
                                                                        (functions.tostr(functions.getkeyfromjsonstring(_model.latestTicketData, 'status')) !=
                                                                            'Departure') &&
                                                                        (functions.tostr(functions.getkeyfromjsonstring(_model.latestTicketData, 'status')) !=
                                                                            'Processing-Departure') &&
                                                                        (functions.tostr(functions.getkeyfromjsonstring(_model.latestTicketData,
                                                                                'status')) !=
                                                                            'Completed'))
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'tntztfzp' /* Enjoy your KNEX experience */,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  font: GoogleFonts.interTight(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 24.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                  lineHeight: 1.1,
                                                                                ),
                                                                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation3']!),
                                                                        ),
                                                                      ),
                                                                    if (functions.tostr(functions.getkeyfromjsonstring(
                                                                            _model.latestTicketData,
                                                                            'status')) ==
                                                                        'Departure')
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              6.0,
                                                                              0.0,
                                                                              6.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            FFLocalizations.of(context).getText(
                                                                              'gzz8c1il' /* Wait your attendant is picking... */,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                  font: GoogleFonts.interTight(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 24.0,
                                                                                  letterSpacing: 1.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                  lineHeight: 1.1,
                                                                                ),
                                                                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation4']!),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        12.0,
                                                                        0.0,
                                                                        12.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    if (functions.tostr(functions.getkeyfromjsonstring(
                                                                            _model.latestTicketData,
                                                                            'status')) ==
                                                                        'Completed')
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            13.0,
                                                                            0.0,
                                                                            7.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '402ocdvf' /* Please Drive Safely */,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleLarge
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                                fontSize: 17.0,
                                                                                letterSpacing: 3.0,
                                                                                lineHeight: 1.1,
                                                                                useGoogleFonts: !FlutterFlowTheme.of(context).titleLargeIsCustom,
                                                                              ),
                                                                        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation5']!),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                                  'columnOnPageLoadAnimation2']!),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      12.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                1.0,
                                                            height: 25.3,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0x00FFFFFF),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              child:
                                                                  BarcodeWidget(
                                                                data:
                                                                    'Ticket ${functions.getkeyfromjsonstring(_model.latestTicketData, 'ticket_number')}',
                                                                barcode: Barcode
                                                                    .code128(),
                                                                width: 100.0,
                                                                height: 30.0,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                errorBuilder:
                                                                    (_context,
                                                                            _error) =>
                                                                        SizedBox(
                                                                  width: 100.0,
                                                                  height: 30.0,
                                                                ),
                                                                drawText: false,
                                                              ),
                                                            ),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                                  'containerOnPageLoadAnimation2']!),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if ((functions.tostr(functions
                                                                    .getkeyfromjsonstring(
                                                                        _model
                                                                            .latestTicketData,
                                                                        'status')) !=
                                                                'Completed') &&
                                                            !_model.accepted)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        8.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onLongPress:
                                                                  () async {
                                                                HapticFeedback
                                                                    .heavyImpact();
                                                                try {
                                                                  final ticketId =
                                                                      functions.getkeyfromjsonstring(
                                                                          _model
                                                                              .latestTicketData,
                                                                          'id');
                                                                  if (ticketId !=
                                                                      null) {
                                                                    final result =
                                                                        await apiClient
                                                                            .setToCancelForClient(ticketId);
                                                                    if (result
                                                                            .status
                                                                            .status ==
                                                                        'UPDATED') {
                                                                      // Handle success
                                                                    } else {
                                                                      // Handle error
                                                                    }
                                                                  }
                                                                } catch (e) {
                                                                  print(e);
                                                                }
                                                              },
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Long press to cancel vallet ticket order.',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                    ),
                                                                  );
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'epyqu0gs' /* Cancel ticket */,
                                                                ),
                                                                icon: Icon(
                                                                  Icons.close,
                                                                  size: 15.0,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.0,
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  iconColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .info,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            FlutterFlowTheme.of(context).titleSmallFamily,
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        useGoogleFonts:
                                                                            !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (_model.accepted)
                                                          Stack(
                                                            children: [
                                                              if (!_model
                                                                  .isRequestLoading)
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          8.0),
                                                                  child:
                                                                      FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      var _shouldSetState =
                                                                          false;
                                                                      if ((functions.getkeyfromjsonstring(_model.latestTicketData, 'lockerSpace') !=
                                                                              'null') &&
                                                                          (functions.getkeyfromjsonstring(_model.latestTicketData, 'parkingSpace') !=
                                                                              'null')) {
                                                                        _model.isRequestLoading =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                        try {
                                                                          final ticketId = functions.getkeyfromjsonstring(
                                                                              _model.latestTicketData,
                                                                              'id');
                                                                          if (ticketId !=
                                                                              null) {
                                                                            final result =
                                                                                await apiClient.setToDeparture(ticketId);
                                                                            if (result.status.status ==
                                                                                'UPDATED') {
                                                                              _model.instantTimer5 = InstantTimer.periodic(
                                                                                duration: Duration(milliseconds: 9500),
                                                                                callback: (timer) async {
                                                                                  try {
                                                                                    final tickets = await apiClient.getTicketList();
                                                                                    if (tickets.isNotEmpty) {
                                                                                      final latestTicket = tickets.first;
                                                                                      _model.latestTicketData = jsonEncode(latestTicket.toMap());
                                                                                      safeSetState(() {});
                                                                                      if (latestTicket.status == 'Processing-Departure') {
                                                                                        context.pushNamed(TicketTimerWidget.routeName);
                                                                                        _model.instantTimer5?.cancel();
                                                                                        return;
                                                                                      }
                                                                                    }
                                                                                  } catch (e) {
                                                                                    print(e);
                                                                                  }
                                                                                },
                                                                                startImmediately: true,
                                                                              );
                                                                            }
                                                                          }
                                                                        } catch (e) {
                                                                          print(
                                                                              e);
                                                                        }
                                                                      } else {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          SnackBar(
                                                                            content:
                                                                                Text(
                                                                              'Wait a moment your attendant still parking your car',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                            duration:
                                                                                Duration(milliseconds: 4000),
                                                                            backgroundColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                          ),
                                                                        );
                                                                        if (_shouldSetState)
                                                                          safeSetState(
                                                                              () {});
                                                                        return;
                                                                      }

                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                    },
                                                                    text: FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'swtih1fg' /* Request Pick Up */,
                                                                    ),
                                                                    icon: Icon(
                                                                      Icons
                                                                          .send,
                                                                      size:
                                                                          15.0,
                                                                    ),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          1.0,
                                                                      height:
                                                                          40.0,
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      iconColor:
                                                                          Colors
                                                                              .white,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleSmallFamily,
                                                                            color:
                                                                                Colors.white,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            useGoogleFonts:
                                                                                !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                                                          ),
                                                                      elevation:
                                                                          0.0,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (_model
                                                                  .isRequestLoading)
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child: Lottie
                                                                        .asset(
                                                                      'assets/jsons/loading.json',
                                                                      width:
                                                                          200.0,
                                                                      height:
                                                                          200.0,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      frameRate:
                                                                          FrameRate(
                                                                              60.0),
                                                                      animate:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation1']!),
                                      ),
                                    ),
                                    if (valueOrDefault<bool>(
                                      (functions.tostr(functions
                                                  .getkeyfromjsonstring(
                                                      _model.latestTicketData,
                                                      'status')) ==
                                              'Completed') &&
                                          _model.isPageLoaded,
                                      false,
                                    ))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 15.0, 15.0, 8.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (Navigator.of(context)
                                                .canPop()) {
                                              context.pop();
                                            }
                                            context.pushNamed(
                                                HomePageWidget.routeName);
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            '4llbinoo' /* Home */,
                                          ),
                                          icon: Icon(
                                            Icons.arrow_back,
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallFamily,
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      useGoogleFonts:
                                                          !FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmallIsCustom,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (_model.isPageLoaded == false)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 210.78,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Lottie.asset(
                                'assets/jsons/loading2.json',
                                width: 207.53,
                                height: 236.3,
                                fit: BoxFit.contain,
                                animate: true,
                              ),
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
    );
  }
}
