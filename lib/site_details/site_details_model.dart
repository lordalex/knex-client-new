import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'site_details_widget.dart' show SiteDetailsWidget;
import 'package:flutter/material.dart';

class SiteDetailsModel extends FlutterFlowModel<SiteDetailsWidget> {
  ///  Local state fields for this page.

  String bio = ' ';

  String name = ' ';

  String company = ' ';

  String address = ' ';

  String businessImage =
      'https://en.wikipedia.org/wiki/Restaurant#/media/File:Interior_of_Le_Bernardin.jpg';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - sendjsontourl] action in SiteDetails widget.
  String? sitedetails;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
