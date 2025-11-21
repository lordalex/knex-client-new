import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'ticket_widget.dart' show TicketWidget;
import 'package:flutter/material.dart';

class TicketModel extends FlutterFlowModel<TicketWidget> {
  ///  Local state fields for this page.

  bool accepted = false;

  String latestTicketData = '{}';

  String attendandData = '{}';

  String? pint;

  bool isPageLoaded = false;

  String? tempData;

  String? queryDataTemp;

  bool boolTest = false;

  bool isTipOpened = false;

  bool isRequestLoading = false;

  bool handlerTipAvoidedBool = false;

  /// when s = completed, will check if home button should be displayed
  bool homeButtonPeriodicHandler = false;

  /// if core periodic on load are off, to toggle isCompleted periodic
  bool homeButtonSwitcherBool = false;

  double doubleCurrentPorcentageLoader = 0.0;

  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  // Stores action output result for [Custom Action - sendjsontourl] action in Ticket widget.
  String? latestTicketDataFrom;
  // Stores action output result for [Custom Action - sendjsontourl] action in Ticket widget.
  String? attendantDataFrom;
  InstantTimer? instantTimer2;
  // Stores action output result for [Custom Action - sendjsontourl] action in Ticket widget.
  String? responsePr;
  // Stores action output result for [Custom Action - sendjsontourl] action in Ticket widget.
  String? isCompletedCheck;
  // Stores action output result for [Custom Action - sendjsontourl] action in IconButton widget.
  String? responsePrManual;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // Stores action output result for [Custom Action - sendjsontourl] action in Button widget.
  String? setToCancel;
  // Stores action output result for [Custom Action - sendjsontourl] action in Button widget.
  String? setToDeparture2;
  InstantTimer? instantTimer5;
  // Stores action output result for [Custom Action - sendjsontourl] action in Button widget.
  String? latestTicketDataFromButton;
  // Stores action output result for [Custom Action - sendjsontourl] action in Button widget.
  String? attendantDataFromButton;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
    instantTimer2?.cancel();
    instantTimer5?.cancel();
  }
}
