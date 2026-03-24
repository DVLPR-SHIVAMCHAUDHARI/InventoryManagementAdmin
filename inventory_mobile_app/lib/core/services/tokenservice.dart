import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  String? get accessToken => _accessToken;
  String? get username => _username;
  String? get userId => _roleId;

  /// STORE USER ID
  Future<void> storeUserRoleId(String roleId) async {
    _roleId = roleId;
    await _storage.write(key: _keyRoleId, value: roleId);
  }

  /// STORE TOKEN
  Future<void> storeTokens({required String accessToken}) async {
    _accessToken = accessToken;
    await _storage.write(key: _keyAccess, value: accessToken);
  }

  /// STORE USERNAME
  Future<void> storeUsername(String username) async {
    _username = username;
    await _storage.write(key: _keyUsername, value: username);
  }

  /// LOAD ALL
  Future<void> load() async {
    _accessToken = await _storage.read(key: _keyAccess);
    _username = await _storage.read(key: _keyUsername);
    _roleId = await _storage.read(key: _keyRoleId);
  }

  /// CLEAR (LOGOUT)
  Future<void> clear() async {
    _accessToken = null;
    _username = null;
    _roleId = null;

    await _storage.delete(key: _keyAccess);
    await _storage.delete(key: _keyUsername);
    await _storage.delete(key: _keyRoleId);
  }
}
