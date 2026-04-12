import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//*Created by Adel Mohsen
//*Date: 2025-03-16
//*Version: 1.3.0
//*Description: SecureStorageService is a wrapper around flutter_secure_storage package that provides
//*Features:
//* - Secure storing of string values
//* - Secure storing of boolean values
//* - Secure storing of integer values
//* - Secure storing of double values
//* - Secure storing of map/JSON values
//* - Secure storing of list values
//* - Batch operations for reading and writing multiple values
//* - Options to delete individual items or clear the entire storage
//* - Encryption key management
//* - Auto-initialization with secure platform-specific configurations
//*Usage example:
//*```dart
//*// Initialize with default secure configurations
//*final secureStorage = SecureStorageService();
//*// Store a sensitive value
//*await secureStorage.write(key: 'api_token', value: 'secret_token_value');
//*// Read a sensitive value
//*final apiToken = await secureStorage.read(key: 'api_token');
//*// Store structured data (automatically serialized to JSON)
//*await secureStorage.writeMap(key: 'user_data', value: {'id': 123, 'role': 'admin'});
//*// Read structured data (automatically deserialized from JSON)
//*final userData = await secureStorage.readMap(key: 'user_data');
//*```
//*
//*Usage example:
//*```dart
//*// Initialize with default secure configurations
//*final secureStorage = SecureStorageService();
//*
//*// Store a sensitive value
//*await secureStorage.write(key: 'api_token', value: 'secret_token_value');
//*
//*// Read a sensitive value
//*final apiToken = await secureStorage.read(key: 'api_token');
//*```
//*
//*Usage example:
//*```dart
//*// Store structured data (automatically serialized to JSON)
//*await secureStorage.writeMap(key: 'user_data', value: {'id': 123, 'role': 'admin'});
//*
//*// Read structured data (automatically deserialized from JSON)
//*final userData = await secureStorage.readMap(key: 'user_data');
//*```

class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  static SecureStorageService? _instance;

  static SecureStorageService get instance {
    _instance ??= SecureStorageService._internal();
    return _instance!;
  }

  factory SecureStorageService() {
    return instance;
  }

  SecureStorageService._internal()
    : _secureStorage = FlutterSecureStorage(
        aOptions: _getAndroidOptions(),
        iOptions: _getIOSOptions(),
      );

  static AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
      sharedPreferencesName: 'com.smartvision.secure_prefs',
      preferencesKeyPrefix: 'secure_storage_',
      resetOnError: true,
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    );
  }

  static IOSOptions _getIOSOptions() {
    return const IOSOptions(
      accountName: 'com.smartvision.secure_account',
      // Don't synchronize with iCloud for higher security
      synchronizable: false,
      // Available after first unlock
      accessibility: KeychainAccessibility.first_unlock,
      groupId: null,
    );
  }

  /// Writes a string value securely
  /// [key] - The key to store the value under
  /// [value] - The string value to be stored
  Future<void> write({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Reads a string value securely
  /// [key] - The key to retrieve the value for
  /// Returns the stored string value or null if not found
  Future<String?> read({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  /// Deletes a value securely
  /// [key] - The key to delete the value for
  Future<void> delete({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  /// Clears all values from secure storage
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  /// Checks if a key exists in the secure storage
  /// [key] - The key to check
  /// Returns true if the key exists, false otherwise
  Future<bool> containsKey({required String key}) async {
    return await _secureStorage.containsKey(key: key);
  }

  /// Reads all key-value pairs from secure storage
  /// Returns a Map<String, String> of all stored key-value pairs
  Future<Map<String, String>> readAll() async {
    return await _secureStorage.readAll();
  }

  /// Writes an integer value securely (converting to string)
  /// [key] - The key to store the value under
  /// [value] - The integer value to be stored
  Future<void> writeInt({required String key, required int value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  /// Reads an integer value securely
  /// [key] - The key to retrieve the value for
  /// Returns the stored integer value or null if not found or not parsable
  Future<int?> readInt({required String key}) async {
    final value = await _secureStorage.read(key: key);
    if (value == null) return null;

    try {
      return int.parse(value);
    } catch (e) {
      return null;
    }
  }

  /// Writes a double value securely (converting to string)
  Future<void> writeDouble({required String key, required double value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  /// Reads a double value securely
  Future<double?> readDouble({required String key}) async {
    final value = await _secureStorage.read(key: key);
    if (value == null) return null;

    try {
      return double.parse(value);
    } catch (e) {
      return null;
    }
  }

  /// Writes a boolean value securely (converting to string)
  Future<void> writeBool({required String key, required bool value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  /// Reads a boolean value securely
  Future<bool?> readBool({required String key}) async {
    final value = await _secureStorage.read(key: key);
    if (value == null) return null;

    return value.toLowerCase() == 'true';
  }

  /// Writes a Map/JSON value securely (converting to JSON string)
  Future<void> writeMap({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    final jsonString = jsonEncode(value);
    await _secureStorage.write(key: key, value: jsonString);
  }

  /// Reads a Map/JSON value securely
  Future<Map<String, dynamic>?> readMap({required String key}) async {
    final jsonString = await _secureStorage.read(key: key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Writes a List value securely (converting to JSON string)
  Future<void> writeList({
    required String key,
    required List<dynamic> value,
  }) async {
    final jsonString = jsonEncode(value);
    await _secureStorage.write(key: key, value: jsonString);
  }

  /// Reads a List value securely
  Future<List<dynamic>?> readList({required String key}) async {
    final jsonString = await _secureStorage.read(key: key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Writes multiple values at once
  Future<void> writeMultiple(Map<String, String> values) async {
    for (final entry in values.entries) {
      await _secureStorage.write(key: entry.key, value: entry.value);
    }
  }

  /// Deletes multiple values at once
  Future<void> deleteMultiple(List<String> keys) async {
    for (final key in keys) {
      await _secureStorage.delete(key: key);
    }
  }

  /// Secure version for handling environment variables
  /// Useful for API keys and other sensitive configurations
  Future<String> getSecureEnvironmentVariable(
    String key, {
    String defaultValue = '',
  }) async {
    final value = await _secureStorage.read(key: 'ENV_$key');
    return value ?? defaultValue;
  }

  /// Set a secure environment variable
  Future<void> setSecureEnvironmentVariable(String key, String value) async {
    await _secureStorage.write(key: 'ENV_$key', value: value);
  }
}
