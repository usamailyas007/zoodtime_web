import 'dart:async';
import 'dart:html' as html;
import 'package:zoodtime_admin/utils/session_storage.dart';

class WebSessionStorage implements SessionStorage {
  @override
  String? getItem(String key) => html.window.sessionStorage[key];

  @override
  Future<void> setItem(String key, String value) async {
    html.window.sessionStorage[key] = value;
  }

  @override
  Future<void> removeItem(String key) async {
    html.window.sessionStorage.remove(key);
  }
}

SessionStorage getSessionStorage() => WebSessionStorage();
