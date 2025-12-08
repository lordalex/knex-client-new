import '/flutter_flow/flutter_flow_util.dart';
import '/utils/florida_messages.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'empty_widget_model.dart';
export 'empty_widget_model.dart';

class EmptyWidgetWidget extends StatefulWidget {
  const EmptyWidgetWidget({super.key});

  @override
  State<EmptyWidgetWidget> createState() => _EmptyWidgetWidgetState();
}

class _EmptyWidgetWidgetState extends State<EmptyWidgetWidget> {
  late EmptyWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyWidgetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
              child: Icon(
                Icons.other_houses_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 64.0,
              ),
            ),
            Text(
              FloridaMessages.noFavoritesYet(context),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    useGoogleFonts:
                        !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
