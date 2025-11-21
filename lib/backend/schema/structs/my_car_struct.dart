// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyCarStruct extends BaseStruct {
  MyCarStruct({
    String? model,
    String? color,
    String? plate,
  })  : _model = model,
        _color = color,
        _plate = plate;

  // "model" field.
  String? _model;
  String get model => _model ?? '';
  set model(String? val) => _model = val;

  bool hasModel() => _model != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "plate" field.
  String? _plate;
  String get plate => _plate ?? '';
  set plate(String? val) => _plate = val;

  bool hasPlate() => _plate != null;

  static MyCarStruct fromMap(Map<String, dynamic> data) => MyCarStruct(
        model: data['model'] as String?,
        color: data['color'] as String?,
        plate: data['plate'] as String?,
      );

  static MyCarStruct? maybeFromMap(dynamic data) =>
      data is Map ? MyCarStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'model': _model,
        'color': _color,
        'plate': _plate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'model': serializeParam(
          _model,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'plate': serializeParam(
          _plate,
          ParamType.String,
        ),
      }.withoutNulls;

  static MyCarStruct fromSerializableMap(Map<String, dynamic> data) =>
      MyCarStruct(
        model: deserializeParam(
          data['model'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        plate: deserializeParam(
          data['plate'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MyCarStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MyCarStruct &&
        model == other.model &&
        color == other.color &&
        plate == other.plate;
  }

  @override
  int get hashCode => const ListEquality().hash([model, color, plate]);
}

MyCarStruct createMyCarStruct({
  String? model,
  String? color,
  String? plate,
}) =>
    MyCarStruct(
      model: model,
      color: color,
      plate: plate,
    );
