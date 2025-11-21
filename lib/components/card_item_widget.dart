import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_item_model.dart';
export 'card_item_model.dart';

class CardItemWidget extends StatefulWidget {
  const CardItemWidget({super.key});

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  late CardItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardItemModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              'https://picsum.photos/seed/761/600',
              width: MediaQuery.sizeOf(context).width * 0.4,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'oxid6zc5' /* KNEX MAIN PARKING LOT */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                      child: Icon(
                        Icons.navigate_next,
                        color: Color(0x7D57636C),
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
