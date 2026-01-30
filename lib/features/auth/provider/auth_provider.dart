import 'package:flutter/material.dart';
import 'user_model.dart';
import '../../shared/utils/logger.dart';

/// Auth Provider - Manages authentication state
class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  /// Sign Up with email and password
  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Mock authentication delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock user creation
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
      );

      _isAuthenticated = true;
      AppLogger.info('User signed up: $email');
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Sign up error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login with email and password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Mock authentication delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock user retrieval
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: email.split('@').first.capitalize(),
        email: email,
      );

      _isAuthenticated = true;
      AppLogger.info('User logged in: $email');
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Login error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Mock logout delay
      await Future.delayed(const Duration(milliseconds: 500));

      _currentUser = null;
      _isAuthenticated = false;
      _errorMessage = null;

      AppLogger.info('User logged out');
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Logout error: $e');
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Mock reset delay
      await Future.delayed(const Duration(milliseconds: 600));

      AppLogger.info('Password reset email sent to: $email');
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Password reset error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

extension _StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
