import 'package:flutter/services.dart';

class FFDevEnvironmentValues {
  static const String currentEnvironment = 'Test';
  static const String environmentValuesPath =
      'assets/environment_values/environment.json';

  static final FFDevEnvironmentValues _instance =
      FFDevEnvironmentValues._internal();

  factory FFDevEnvironmentValues() {
    return _instance;
  }

  FFDevEnvironmentValues._internal();

  Future<String> initialize() async {
    try {
      final response = await rootBundle.loadString(environmentValuesPath);
      return response;
    } catch (e) {
      print('Error loading environment values: $e');
      return '';
    }
  }
}
