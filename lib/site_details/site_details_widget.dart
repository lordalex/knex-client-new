import '/backend/api_client/api_client.dart';
import '/backend/api_client/models/index.dart' as models;
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';
import 'site_details_model.dart';
export 'site_details_model.dart';

/// This page shows the details for the site and show the option to call for
/// valet or cancel.
class SiteDetailsWidget extends StatefulWidget {
  const SiteDetailsWidget({
    super.key,
    required this.id,
  });

  final String? id;

  static String routeName = 'SiteDetails';
  static String routePath = '/siteDetails';

  @override
  State<SiteDetailsWidget> createState() => _SiteDetailsWidgetState();
}

class _SiteDetailsWidgetState extends State<SiteDetailsWidget> {
  late SiteDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SiteDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        final apiClient = ApiClient();
        final locations = await apiClient.getLocations();
        final location =
            locations.firstWhereOrNull((loc) => loc.id == widget.id);
        if (location != null) {
          _model.name = location.name;
          _model.address = location.address ?? '';
          
          // Populate the sitedetails string which is required by the UI
          _model.sitedetails = jsonEncode(location.toMap());
          
          // Bio, company and businessImage are not in the new model
          _model.bio = '';
          _model.company = '';
          
          // Use a placeholder if image is missing to prevent NetworkImage crash
          _model.businessImage = 'https://placehold.co/600x400';
          
          safeSetState(() {});
        }
      } catch (e) {
        print(e);
      }
    });

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
                    color: FlutterFlowTheme.of(context).info,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  FFLocalizations.of(context).getText(
                    'tqhw2zbm' /* Details */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).headlineMediumFamily,
                        color: FlutterFlowTheme.of(context).info,
                        letterSpacing: 0.0,
                        useGoogleFonts: !FlutterFlowTheme.of(context)
                            .headlineMediumIsCustom,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: FlutterFlowExpandedImageView(
                            image: Image.network(
                              functions.stringToImagePath(_model.businessImage),
                              fit: BoxFit.contain,
                            ),
                            allowRotation: false,
                            tag: functions
                                .stringToImagePath(_model.businessImage),
                            useHeroAnimation: true,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: functions.stringToImagePath(_model.businessImage),
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          functions.stringToImagePath(_model.businessImage),
                          width: double.infinity,
                          height: 160.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    'ukhpjb32' /* Primary Site */,
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).labelMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).labelMediumIsCustom,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                  child: Text(
                    functions.tostr(_model.name),
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily:
                              FlutterFlowTheme.of(context).headlineMediumFamily,
                          letterSpacing: 0.0,
                          useGoogleFonts: !FlutterFlowTheme.of(context)
                              .headlineMediumIsCustom,
                        ),
                  ),
                ),
                Text(
                  functions.tostr(valueOrDefault<String>(
                    _model.address,
                    '12442 Eastwood Ln, Arizona',
                  )),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyMediumFamily,
                        letterSpacing: 0.0,
                        useGoogleFonts:
                            !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: RatingBar.builder(
                    onRatingUpdate: (newValue) =>
                        safeSetState(() => _model.ratingBarValue = newValue),
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rounded,
                      color: FlutterFlowTheme.of(context).warning,
                    ),
                    direction: Axis.horizontal,
                    initialRating: _model.ratingBarValue ??= 4.0,
                    unratedColor: FlutterFlowTheme.of(context).alternate,
                    itemCount: 5,
                    itemSize: 24.0,
                    glowColor: FlutterFlowTheme.of(context).warning,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
                  child: Container(
                    width: double.infinity,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Disclaimer'),
                                    content: Text(
                                        'All vehicles are parked at the owner\'s risk.Management assumes no liability for theft, fire, damage or loss of use to any car, equipment or articles left in car or liability for cars left after closing.All claims must be made before leaving premises.Cars will not be delivered without a PIN number. We reserve the right to move cars and refuse service.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              context.pushNamed(
                                AddCarsWidget.routeName,
                                queryParameters: {
                                  'id': serializeParam(
                                    widget.id,
                                    ParamType.String,
                                  ),
                                  'notesJson': serializeParam(
                                    functions.getkeyfromjsonstring(
                                        _model.sitedetails!, 'notes'),
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: Icon(
                                    Icons.emoji_people_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 12.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '691zx32k' /* Request Vallet */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100.0,
                          child: VerticalDivider(
                            thickness: 1.0,
                            indent: 12.0,
                            endIndent: 12.0,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await launchUrl(Uri(
                              scheme: 'tel',
                              path: '55454587',
                            ));
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: Icon(
                                    Icons.call_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 12.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ikgmfq97' /* Call */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyMediumIsCustom,
                                        ),
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
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        height: MediaQuery.sizeOf(context).height * 0.55,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 8.0, 5.0, 12.0),
                            child: Text(
                              functions.tostr(_model.bio),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts:
                                        !FlutterFlowTheme.of(context)
                                            .labelMediumIsCustom,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 30.0,
                  decoration: BoxDecoration(),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (FFAppState().myFavs.contains(widget.id) == false)
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (FFAppState()
                                            .myFavs
                                            .contains(_model.sitedetails) ==
                                        true) {
                                      FFAppState().removeFromMyFavs(
                                          _model.sitedetails!);
                                      safeSetState(() {});
                                    } else {
                                      FFAppState()
                                          .addToMyFavs(_model.sitedetails!);
                                      safeSetState(() {});
                                    }
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'o6ipanl1' /* Favorite Site */,
                                  ),
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 48.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLargeFamily,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyLargeIsCustom,
                                        ),
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          if (FFAppState().myFavs.contains(widget.id) == true)
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (FFAppState()
                                            .myFavs
                                            .contains(_model.sitedetails) ==
                                        true) {
                                      FFAppState().removeFromMyFavs(
                                          _model.sitedetails!);
                                      safeSetState(() {});
                                    } else {
                                      FFAppState()
                                          .addToMyFavs(_model.sitedetails!);
                                      safeSetState(() {});
                                    }
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'rezxzsxc' /* Remove site from favorites */,
                                  ),
                                  icon: Icon(
                                    Icons.favorite_sharp,
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 48.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconColor:
                                        FlutterFlowTheme.of(context).info,
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLargeFamily,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          letterSpacing: 0.0,
                                          useGoogleFonts:
                                              !FlutterFlowTheme.of(context)
                                                  .bodyLargeIsCustom,
                                        ),
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
