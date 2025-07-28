import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late final SharedPreferences _prefs;
  static final GetStorage _box = GetStorage();
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (!_isInitialized) {
      try {
        _prefs = await SharedPreferences.getInstance();
        await GetStorage.init();
        _isInitialized = true;
      } catch (e) {
        throw Exception('Failed to initialize storage: $e');
      }
    }
  }

  // Onboarding
  static Future<void> setOnboardingSeen(bool seen) async {
    _ensureInitialized();
    await _prefs.setBool('onboarding_seen', seen);
  }

  static bool hasSeenOnboarding() {
    _ensureInitialized();
    return _prefs.getBool('onboarding_seen') ?? false;
  }

  // Auth
  static Future<void> setLoggedIn(bool value) async {
    _ensureInitialized();
    await _prefs.setBool('is_logged_in', value);
  }

  static bool isLoggedIn() {
    _ensureInitialized();
    return _prefs.getBool('is_logged_in') ?? false;
  }

  static Future<void> saveAuthToken(String token) async {
    _ensureInitialized();
    await _prefs.setString('auth_token', token);
  }

  static String? getAuthToken() {
    _ensureInitialized();
    return _prefs.getString('auth_token');
  }

  // User Data
  static Future<void> saveUserData({
    required String id,
    required String name,
    required String email,
  }) async {
    _ensureInitialized();
    await Future.wait([
      _prefs.setString('user_id', id),
      _prefs.setString('user_name', name),
      _prefs.setString('user_email', email),
    ]);
  }

  static Future<void> clearUserData() async {
    _ensureInitialized();
    await Future.wait([
      _prefs.remove('is_logged_in'),
      _prefs.remove('auth_token'),
      _prefs.remove('user_id'),
      _prefs.remove('user_name'),
      _prefs.remove('user_email'),
    ]);
  }

  // Private helper
  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception('StorageService not initialized. Call init() first');
    }
  }
}