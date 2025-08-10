abstract class SessionStorage {
  String? getItem(String key);
  Future<void> setItem(String key, String value);
  Future<void> removeItem(String key);
}
