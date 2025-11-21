import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'profile_create_widget.dart' show ProfileCreateWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileCreateModel extends FlutterFlowModel<ProfileCreateWidget> {
  ///  Local state fields for this page.

  String? firstname = ' ';

  String? lastname = ' ';

  String? phone = ' ';

  String? address = ' ';

  String? city;

  String? state;

  bool currentProfilePic = false;

  bool errorStateProfileImg = false;

  bool isQueryLoaded = false;

  FFUploadedFile? photo;

  bool testQuery = false;

  /// if profile is edited
  bool isEdited = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - sendjsontourl] action in ProfileCreate widget.
  String? response;
  // Stores action output result for [Custom Action - base64toBytesAction] action in ProfileCreate widget.
  FFUploadedFile? photoReturned;
  bool isDataUploading_uploadData1mc = false;
  FFUploadedFile uploadedLocalFile_uploadData1mc =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  String? _yourNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'e9y3wlgj' /* firstname is required */,
      );
    }

    return null;
  }

  // State field(s) for yourLastName widget.
  FocusNode? yourLastNameFocusNode;
  TextEditingController? yourLastNameTextController;
  String? Function(BuildContext, String?)? yourLastNameTextControllerValidator;
  String? _yourLastNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '4q4zy28w' /* lastname is required */,
      );
    }

    return null;
  }

  // State field(s) for PhoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  late MaskTextInputFormatter phoneNumberMask;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'youciqi8' /* phone is required */,
      );
    }

    if (val.length < 6) {
      return 'Requires at least 6 characters.';
    }

    return null;
  }

  // State field(s) for Address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  String? _addressTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'shymfkul' /* Address is required */,
      );
    }

    return null;
  }

  // State field(s) for zipcode widget.
  FocusNode? zipcodeFocusNode;
  TextEditingController? zipcodeTextController;
  String? Function(BuildContext, String?)? zipcodeTextControllerValidator;
  String? _zipcodeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'xi4kkynl' /* Zip code is required */,
      );
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for city widget.
  FocusNode? cityFocusNode;
  TextEditingController? cityTextController;
  String? Function(BuildContext, String?)? cityTextControllerValidator;
  String? _cityTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'u51agwne' /* City is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Custom Action - bytesToCompressedBytes] action in Button widget.
  FFUploadedFile? compressedBytes;
  // Stores action output result for [Custom Action - bytestobase64Action] action in Button widget.
  String? imageBytesToBase64;
  // Stores action output result for [Custom Action - sendprofile] action in Button widget.
  String? profileoutput;

  @override
  void initState(BuildContext context) {
    yourNameTextControllerValidator = _yourNameTextControllerValidator;
    yourLastNameTextControllerValidator = _yourLastNameTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    zipcodeTextControllerValidator = _zipcodeTextControllerValidator;
    cityTextControllerValidator = _cityTextControllerValidator;
  }

  @override
  void dispose() {
    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    yourLastNameFocusNode?.dispose();
    yourLastNameTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    zipcodeFocusNode?.dispose();
    zipcodeTextController?.dispose();

    cityFocusNode?.dispose();
    cityTextController?.dispose();
  }
}
