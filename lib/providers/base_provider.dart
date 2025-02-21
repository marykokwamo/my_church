import 'package:flutter/foundation.dart';

enum LoadingState { initial, loading, loaded, error }

class BaseProvider with ChangeNotifier {
  LoadingState _state = LoadingState.initial;
  String? _error;
  bool _isDisposed = false;

  LoadingState get state => _state;
  String? get error => _error;
  bool get isLoading => _state == LoadingState.loading;
  bool get hasError => _state == LoadingState.error;
  bool get isLoaded => _state == LoadingState.loaded;

  @protected
  void setLoading() {
    _state = LoadingState.loading;
    _error = null;
    _notifyIfNotDisposed();
  }

  @protected
  void setLoaded() {
    _state = LoadingState.loaded;
    _error = null;
    _notifyIfNotDisposed();
  }

  @protected
  void setError(String error) {
    _state = LoadingState.error;
    _error = error;
    _notifyIfNotDisposed();
  }

  void _notifyIfNotDisposed() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @protected
  Future<void> wrapError(Future<void> Function() fn) async {
    try {
      setLoading();
      await fn();
      setLoaded();
    } catch (e) {
      setError(e.toString());
      rethrow;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
