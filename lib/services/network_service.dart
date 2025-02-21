import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final _cache = <String, _CacheEntry>{};
  static const _cacheDuration = Duration(minutes: 5);
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadPersistedCache();
  }

  Future<Map<String, dynamic>> get(String url, {bool forceRefresh = false}) async {
    if (!forceRefresh && _cache.containsKey(url)) {
      final entry = _cache[url]!;
      if (DateTime.now().difference(entry.timestamp) < _cacheDuration) {
        return json.decode(entry.data);
      }
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        _cache[url] = _CacheEntry(data, DateTime.now());
        _persistCache();
        return json.decode(data);
      } else {
        throw NetworkException('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      if (_cache.containsKey(url)) {
        // Return cached data if available, even if expired
        return json.decode(_cache[url]!.data);
      }
      throw NetworkException('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw NetworkException('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  void clearCache() {
    _cache.clear();
    _prefs.remove('network_cache');
  }

  void _persistCache() {
    final serializedCache = _cache.map((key, value) => MapEntry(
        key, {'data': value.data, 'timestamp': value.timestamp.toIso8601String()}));
    _prefs.setString('network_cache', json.encode(serializedCache));
  }

  void _loadPersistedCache() {
    final serializedCache = _prefs.getString('network_cache');
    if (serializedCache != null) {
      final Map<String, dynamic> decoded = json.decode(serializedCache);
      _cache.clear();
      decoded.forEach((key, value) {
        _cache[key] = _CacheEntry(
          value['data'] as String,
          DateTime.parse(value['timestamp'] as String),
        );
      });
    }
  }
}

class _CacheEntry {
  final String data;
  final DateTime timestamp;

  _CacheEntry(this.data, this.timestamp);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => message;
}
