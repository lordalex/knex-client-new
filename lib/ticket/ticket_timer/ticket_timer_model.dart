import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'ticket_timer_widget.dart' show TicketTimerWidget;
import 'package:flutter/material.dart';

class TicketTimerModel extends FlutterFlowModel<TicketTimerWidget> {
  ///  Local state fields for this page.

  bool accepted = false;

  String laestTicketData = '{}';

  String attendandData = '{}';

  String? pint;

  bool timerEnded = false;

  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimerTicket;
  // Stores action output result for [Custom Action - sendjsontourl] action in TicketTimer widget.
  String? responsePIN;
  // Stores action output result for [Custom Action - sendjsontourl] action in TicketTimer widget.
  String? latestTicketDataFrom;
  // Stores action output result for [Custom Action - sendjsontourl] action in IconButton widget.
  String? responsePrManual;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 300000;
  int timerMilliseconds = 300000;
  String timerValue = StopWatchTimer.getDisplayTime(
    300000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimerTicket?.cancel();
    timerController.dispose();
  }
}
