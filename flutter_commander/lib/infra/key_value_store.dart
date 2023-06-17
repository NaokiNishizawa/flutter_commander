import 'package:flutter_commander/enums/key_value_store_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final keyValueStoreProvider = Provider<KeyValueStore>(
  (ref) => KeyValueStoreImpl()..init(),
);

/// ローカルにキーと値をペアで保存する
abstract class KeyValueStore {
  Future<void> init();
  String getString(KeyValueStoreKey key);
  Future<bool> setString(KeyValueStoreKey key, String setValue);
}

class KeyValueStoreImpl extends KeyValueStore {
  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  String getString(KeyValueStoreKey key) {
    if (_prefs == null) {
      return '';
    }

    final rtn = _prefs!.getString(key.value);
    return rtn ?? '';
  }

  @override
  Future<bool> setString(KeyValueStoreKey key, String setValue) async {
    if (_prefs == null) {
      return Future<bool>.value(false);
    }

    final rtn = await _prefs!.setString(key.value, setValue);
    return rtn;
  }
}
