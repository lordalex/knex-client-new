import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _UserProfileCreated =
          prefs.getBool('ff_UserProfileCreated') ?? _UserProfileCreated;
    });
    _safeInit(() {
      _UserEmailValidated =
          prefs.getBool('ff_UserEmailValidated') ?? _UserEmailValidated;
    });
    _safeInit(() {
      _myFavs = prefs.getStringList('ff_myFavs') ?? _myFavs;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_myCar')) {
        try {
          final serializedData = prefs.getString('ff_myCar') ?? '{}';
          _myCar = MyCarStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _distanceUnit = prefs.getString('ff_distanceUnit') ?? _distanceUnit;
    });
    _safeInit(() {
      _sorAscending = prefs.getBool('ff_sorAscending') ?? _sorAscending;
    });
    _safeInit(() {
      _sortBy = prefs.getString('ff_sortBy') ?? _sortBy;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _UserProfileCreated = false;
  bool get UserProfileCreated => _UserProfileCreated;
  set UserProfileCreated(bool value) {
    _UserProfileCreated = value;
    prefs.setBool('ff_UserProfileCreated', value);
  }

  bool _UserEmailValidated = false;
  bool get UserEmailValidated => _UserEmailValidated;
  set UserEmailValidated(bool value) {
    _UserEmailValidated = value;
    prefs.setBool('ff_UserEmailValidated', value);
  }

  LatLng? _destinationLatLon = LatLng(26.132895, -80.104208);
  LatLng? get destinationLatLon => _destinationLatLon;
  set destinationLatLon(LatLng? value) {
    _destinationLatLon = value;
  }

  List<String> _myFavs = [];
  List<String> get myFavs => _myFavs;
  set myFavs(List<String> value) {
    _myFavs = value;
    prefs.setStringList('ff_myFavs', value);
  }

  void addToMyFavs(String value) {
    myFavs.add(value);
    prefs.setStringList('ff_myFavs', _myFavs);
  }

  void removeFromMyFavs(String value) {
    myFavs.remove(value);
    prefs.setStringList('ff_myFavs', _myFavs);
  }

  void removeAtIndexFromMyFavs(int index) {
    myFavs.removeAt(index);
    prefs.setStringList('ff_myFavs', _myFavs);
  }

  void updateMyFavsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    myFavs[index] = updateFn(_myFavs[index]);
    prefs.setStringList('ff_myFavs', _myFavs);
  }

  void insertAtIndexInMyFavs(int index, String value) {
    myFavs.insert(index, value);
    prefs.setStringList('ff_myFavs', _myFavs);
  }

  String _base64 = '';
  String get base64 => _base64;
  set base64(String value) {
    _base64 = value;
  }

  /// car selected in /addCar
  MyCarStruct _myCar = MyCarStruct();
  MyCarStruct get myCar => _myCar;
  set myCar(MyCarStruct value) {
    _myCar = value;
    prefs.setString('ff_myCar', value.serialize());
  }

  void updateMyCarStruct(Function(MyCarStruct) updateFn) {
    updateFn(_myCar);
    prefs.setString('ff_myCar', _myCar.serialize());
  }

  String _distanceUnit = 'metric';
  String get distanceUnit => _distanceUnit;
  set distanceUnit(String value) {
    _distanceUnit = value;
    prefs.setString('ff_distanceUnit', value);
  }

  bool _sorAscending = false;
  bool get sorAscending => _sorAscending;
  set sorAscending(bool value) {
    _sorAscending = value;
    prefs.setBool('ff_sorAscending', value);
  }

  String _sortBy = 'distance';
  String get sortBy => _sortBy;
  set sortBy(String value) {
    _sortBy = value;
    prefs.setString('ff_sortBy', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
