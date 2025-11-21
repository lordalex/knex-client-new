import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'city_dropdown_model.dart';
export 'city_dropdown_model.dart';

class CityDropdownWidget extends StatefulWidget {
  const CityDropdownWidget({
    super.key,
    this.parameter1,
  });

  final String? parameter1;

  @override
  State<CityDropdownWidget> createState() => _CityDropdownWidgetState();
}

class _CityDropdownWidgetState extends State<CityDropdownWidget> {
  late CityDropdownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CityDropdownModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 9.0, 10.0),
      child: Stack(
        alignment: AlignmentDirectional(-1.0, 0.0),
        children: [
          FlutterFlowDropDown<String>(
            controller: _model.dropDownValueController ??=
                FormFieldController<String>(null),
            options: functions.citiesList(widget.parameter1),
            onChanged: (val) => safeSetState(() => _model.dropDownValue = val),
            width: MediaQuery.sizeOf(context).width * 0.998,
            height: 48.9,
            searchHintTextStyle: FlutterFlowTheme.of(context)
                .labelMedium
                .override(
                  fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).labelMediumIsCustom,
                ),
            searchTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                ),
            hintText: FFLocalizations.of(context).getText(
              'u5m4bvti' /* City */,
            ),
            searchHintText: FFLocalizations.of(context).getText(
              'rbh6s671' /* Search... */,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 2.0,
            borderColor: FlutterFlowTheme.of(context).alternate,
            borderWidth: 2.0,
            borderRadius: 24.0,
            margin: EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 12.0, 0.0),
            hidesUnderline: true,
            disabled: widget.parameter1 == null || widget.parameter1 == '',
            isOverButton: false,
            isSearchable: true,
            isMultiSelect: false,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
            child: Icon(
              Icons.location_pin,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
