import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:html' as html;

class TokenServices {
  static final TokenServices _instance = TokenServices._internal();
  factory TokenServices() => _instance;
  TokenServices._internal();

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _keyAccess = "x-auth-token";
  static const _keyUsername = "username";
  static const _keyRoleId = "user_id";

  String? _accessToken;
  String? _username;
  String? _roleId;
  String? get userId => _roleId;

  String? get accessToken => _accessToken;
  String? get username => _username;

  //storing userid

  Future<void> storeUserRoleId(String roleId) async {
    _roleId = userId;

    if (kIsWeb) {
      html.window.sessionStorage[_keyRoleId] = roleId;
    } else {
      await _storage.write(key: _keyRoleId, value: userId);
    }
  }

  /// STORE TOKEN
  Future<void> storeTokens({required String accessToken}) async {
    _accessToken = accessToken;

    if (kIsWeb) {
      html.window.sessionStorage[_keyAccess] = accessToken;
    } else {
      await _storage.write(key: _keyAccess, value: accessToken);
    }
  }

  /// STORE USERNAME
  Future<void> storeUsername(String username) async {
    _username = username;

    if (kIsWeb) {
      html.window.sessionStorage[_keyUsername] = username;
    } else {
      await _storage.write(key: _keyUsername, value: username);
    }
  }

  /// LOAD TOKENS
  Future<void> load() async {
    if (kIsWeb) {
      _accessToken = html.window.sessionStorage[_keyAccess];
      _username = html.window.sessionStorage[_keyUsername];
      _roleId = kIsWeb
          ? html.window.sessionStorage[_keyRoleId]
          : await _storage.read(key: _keyRoleId);
    } else {
      _accessToken = await _storage.read(key: _keyAccess);
      _username = await _storage.read(key: _keyUsername);
    }
  }

  /// CLEAR TOKEN (LOGOUT)
  Future<void> clear() async {
    _accessToken = null;
    _username = null;

    if (kIsWeb) {
      html.window.sessionStorage.remove(_keyAccess);
      html.window.sessionStorage.remove(_keyUsername);
      html.window.sessionStorage.remove(_keyRoleId);
    } else {
      await _storage.deleteAll();
    }
  }
}
