import 'package:logger/logger.dart';

class LoggerManager {
  static final LoggerManager _instance = LoggerManager._init();
  static LoggerManager get instance => _instance;
  LoggerManager._init();

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  void debug(dynamic message) {
    logger.d(message);
  }

  void info(dynamic message) {
    logger.i(message);
  }

  void warning(dynamic message) {
    logger.w(message);
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  void verbose(dynamic message) {
    logger.v(message);
  }

  void wtf(dynamic message) {
    logger.wtf(message);
  }
} 