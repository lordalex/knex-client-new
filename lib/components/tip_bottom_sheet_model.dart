import '/flutter_flow/flutter_flow_util.dart';
import 'tip_bottom_sheet_widget.dart' show TipBottomSheetWidget;
import 'package:flutter/material.dart';

class TipBottomSheetModel extends FlutterFlowModel<TipBottomSheetWidget> {
  ///  Local state fields for this component.

  int integerSelector = 0;

  String finalTip = '0';

  String? customAmount;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Stripe Payment] action in Button widget.
  String? paymentId;
  // Stores action output result for [Custom Action - sendjsontourl] action in Button widget.
  String? paymentIdResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
