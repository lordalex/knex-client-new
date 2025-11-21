import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  Local state fields for this page.

  String? fullname;

  FFUploadedFile? photo;

  String email = 'err';

  bool isQueryLoaded = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - sendjsontourl] action in Profile widget.
  String? response;
  // Stores action output result for [Custom Action - base64toBytesAction] action in Profile widget.
  FFUploadedFile? photoReturned;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
