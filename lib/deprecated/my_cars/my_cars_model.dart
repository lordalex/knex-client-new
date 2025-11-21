import '/components/card_list_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'my_cars_widget.dart' show MyCarsWidget;
import 'package:flutter/material.dart';

class MyCarsModel extends FlutterFlowModel<MyCarsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for CardListComponent component.
  late CardListComponentModel cardListComponentModel;

  @override
  void initState(BuildContext context) {
    cardListComponentModel =
        createModel(context, () => CardListComponentModel());
  }

  @override
  void dispose() {
    cardListComponentModel.dispose();
  }
}
