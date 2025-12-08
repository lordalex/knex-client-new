import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String response = ' ';

  String pin = ' ';

  String pint = ' ';

  List<String> sites = [];
  void addToSites(String item) => sites.add(item);
  void removeFromSites(String item) => sites.remove(item);
  void removeAtIndexFromSites(int index) => sites.removeAt(index);
  void insertAtIndexInSites(int index, String item) =>
      sites.insert(index, item);
  void updateSitesAtIndex(int index, Function(String) updateFn) =>
      sites[index] = updateFn(sites[index]);

  String location = ' ';

  bool timerBoolFirstStart = false;

  bool timerBoolisBlocked = false;

  bool isLoaded = false;

  /// Error state fields
  bool hasError = false;
  String? errorMessage;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - sendjsontourl] action in HomePage widget.
  String? responseR;
  // Stores action output result for [Custom Action - sendjsontourl] action in HomePage widget.
  String? responseP;
  // Stores action output result for [Custom Action - sendjsontourl] action in HomePage widget.
  String? responseQ;
  // Stores action output result for [Custom Action - sortstringarraybyargs] action in HomePage widget.
  List<String>? sitesWithDistance;
  // Stores action output result for [Custom Action - sendjsontourl] action in HomePage widget.
  String? latestTicketDataFrom;
  // Stores action output result for [Custom Action - location] action in HomePage widget.
  String? locationL;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // Stores action output result for [Stripe Payment] action in Text widget.
  String? paymentId;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
