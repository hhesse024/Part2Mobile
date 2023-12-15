import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final String _usernameKey = 'username';
  final String _passwordKey = 'password';

  SecureStorage();

  Future<void> saveCredentials(String username, String password) async {
    await _secureStorage.write(key: _usernameKey, value: username);
    await _secureStorage.write(key: _passwordKey, value: password);
  }

  Future<String?> getUsername() async {
    return await _secureStorage.read(key: _usernameKey);
  }

  Future<String?> getPassword() async {
    return await _secureStorage.read(key: _passwordKey);
  }
}
