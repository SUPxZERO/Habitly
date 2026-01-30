import 'package:logger/logger.dart';

/// App Logger - Centralized logging
final logger = Logger(
  printer: PrettyPrinter(
    colors: true,
    printEmojis: true,
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
  ),
);

/// App-wide logging methods
class AppLogger {
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error, stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error, stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error, stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error, stackTrace);
  }

  static void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.v(message, error, stackTrace);
  }

  static void wtf(String message, [dynamic error, StackTrace? stackTrace]) {
    logger.wtf(message, error, stackTrace);
  }
}
