import 'package:get_storage/get_storage.dart';

import 'session_storage.dart';

class NonWebSessionStorage implements SessionStorage {
  final GetStorage _box = GetStorage();

  @override
  String? getItem(String key) => _box.read(key)?.toString();

  @override
  Future<void> setItem(String key, String value) async {
    await _box.write(key, value);
  }

  @override
  Future<void> removeItem(String key) async {
    await _box.remove(key);
  }
}

SessionStorage getSessionStorage() => NonWebSessionStorage();
