import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_cars_widget.dart' show AddCarsWidget;
import 'package:flutter/material.dart';

class AddCarsModel extends FlutterFlowModel<AddCarsWidget> {
  ///  Local state fields for this page.

  List<String> notesList = [];
  void addToNotesList(String item) => notesList.add(item);
  void removeFromNotesList(String item) => notesList.remove(item);
  void removeAtIndexFromNotesList(int index) => notesList.removeAt(index);
  void insertAtIndexInNotesList(int index, String item) =>
      notesList.insert(index, item);
  void updateNotesListAtIndex(int index, Function(String) updateFn) =>
      notesList[index] = updateFn(notesList[index]);

  List<String> noteSelected = [];
  void addToNoteSelected(String item) => noteSelected.add(item);
  void removeFromNoteSelected(String item) => noteSelected.remove(item);
  void removeAtIndexFromNoteSelected(int index) => noteSelected.removeAt(index);
  void insertAtIndexInNoteSelected(int index, String item) =>
      noteSelected.insert(index, item);
  void updateNoteSelectedAtIndex(int index, Function(String) updateFn) =>
      noteSelected[index] = updateFn(noteSelected[index]);

  bool customNotes = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for model widget.
  FocusNode? modelFocusNode;
  TextEditingController? modelTextController;
  String? Function(BuildContext, String?)? modelTextControllerValidator;
  // State field(s) for color widget.
  FocusNode? colorFocusNode;
  TextEditingController? colorTextController;
  String? Function(BuildContext, String?)? colorTextControllerValidator;
  // State field(s) for plate widget.
  FocusNode? plateFocusNode;
  TextEditingController? plateTextController;
  String? Function(BuildContext, String?)? plateTextControllerValidator;
  // State field(s) for Checkbox widget.
  Map<String, bool> checkboxValueMap1 = {};
  List<String> get checkboxCheckedItems1 => checkboxValueMap1.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // Stores action output result for [Custom Action - createTicket] action in saveButton widget.
  String? ticketcreated;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    modelFocusNode?.dispose();
    modelTextController?.dispose();

    colorFocusNode?.dispose();
    colorTextController?.dispose();

    plateFocusNode?.dispose();
    plateTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController4?.dispose();
  }
}
