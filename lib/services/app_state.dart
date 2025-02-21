import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AppState manages the global application state using ChangeNotifier pattern.
/// This includes user preferences, authentication state, and app settings.
class AppState extends ChangeNotifier {
  // Singleton instance
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // SharedPreferences instance
  late SharedPreferences _prefs;

  // Theme mode state
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  // Authentication state
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;

  // Church selection state
  String? _selectedChurchId;
  String? get selectedChurchId => _selectedChurchId;
  String? _selectedChurchName;
  String? get selectedChurchName => _selectedChurchName;

  // Initialize the app state
  Future<void> initializeAppState() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load theme mode
    final isDark = _prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    // Load authentication state
    _isAuthenticated = _prefs.getBool('isAuthenticated') ?? false;
    _phoneNumber = _prefs.getString('phoneNumber');

    // Load church selection
    _selectedChurchId = _prefs.getString('selectedChurchId');
    _selectedChurchName = _prefs.getString('selectedChurchName');

    notifyListeners();
  }

  // Theme mode methods
  void setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    await _prefs.setBool('isDarkMode', mode == ThemeMode.dark);
    notifyListeners();
  }

  // Authentication methods
  Future<void> signIn(String phoneNumber) async {
    _isAuthenticated = true;
    _phoneNumber = phoneNumber;
    
    await _prefs.setBool('isAuthenticated', true);
    await _prefs.setString('phoneNumber', phoneNumber);
    
    notifyListeners();
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _phoneNumber = null;
    _selectedChurchId = null;
    _selectedChurchName = null;
    
    await _prefs.setBool('isAuthenticated', false);
    await _prefs.remove('phoneNumber');
    await _prefs.remove('selectedChurchId');
    await _prefs.remove('selectedChurchName');
    
    notifyListeners();
  }

  // Church selection methods
  Future<void> selectChurch(String churchId, String churchName) async {
    _selectedChurchId = churchId;
    _selectedChurchName = churchName;
    
    await _prefs.setString('selectedChurchId', churchId);
    await _prefs.setString('selectedChurchName', churchName);
    
    notifyListeners();
  }

  Future<void> clearChurchSelection() async {
    _selectedChurchId = null;
    _selectedChurchName = null;
    
    await _prefs.remove('selectedChurchId');
    await _prefs.remove('selectedChurchName');
    
    notifyListeners();
  }
}
