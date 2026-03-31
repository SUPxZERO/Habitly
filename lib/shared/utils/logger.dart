import 'package:logger/logger.dart';

/// App Logger - Centralized logging
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
);

/// App-wide logging methods
class AppLogger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    // In newer logger versions, verbose (v) is replaced by trace (t)
    logger.t(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    // In newer logger versions, wtf is replaced by fatal (f)
    logger.f(message, error: error, stackTrace: stackTrace);
  }
}
