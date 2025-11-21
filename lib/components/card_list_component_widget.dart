import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'card_list_component_model.dart';
export 'card_list_component_model.dart';

class CardListComponentWidget extends StatefulWidget {
  const CardListComponentWidget({
    super.key,
    String? nameCar,
    String? carPlate,
  })  : this.nameCar = nameCar ?? 'Car',
        this.carPlate = carPlate ?? '123ABC';

  final String nameCar;
  final String carPlate;

  @override
  State<CardListComponentWidget> createState() =>
      _CardListComponentWidgetState();
}

class _CardListComponentWidgetState extends State<CardListComponentWidget> {
  late CardListComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardListComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 3.0,
              color: Color(0x411D2429),
              offset: Offset(
                0.0,
                1.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 1.0, 1.0, 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1463462927315-fb10af2c68d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxOXx8Y2FyfGVufDB8fHx8MTczMzI0NTIwN3ww&ixlib=rb-4.0.3&q=80&w=1080',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 4.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nameCar,
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  letterSpacing: 0.0,
                                  useGoogleFonts: !FlutterFlowTheme.of(context)
                                      .headlineSmallIsCustom,
                                ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 8.0, 0.0),
                        child: AutoSizeText(
                          widget.carPlate.maybeHandleOverflow(
                            maxChars: 70,
                            replacement: '…',
                          ),
                          textAlign: TextAlign.start,
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
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF57636C),
                      size: 24.0,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 4.0, 8.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '50flunob' /*  */,
                      ),
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            letterSpacing: 0.0,
                            useGoogleFonts: !FlutterFlowTheme.of(context)
                                .bodyMediumIsCustom,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
