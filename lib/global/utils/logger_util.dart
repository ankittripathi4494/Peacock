

import 'package:talker/talker.dart';

class LoggerUtil {
  static final LoggerUtil _instance = LoggerUtil._internal();
  final Talker talkerLogger = Talker(
    logger: TalkerLogger(formatter: ColoredLoggerFormatter()),
    settings: TalkerSettings(colors: {
      TalkerLogType.critical: AnsiPen()..gray(),
      TalkerLogType.error: AnsiPen()..red(),
      TalkerLogType.info: AnsiPen()..blue(),
      TalkerLogType.warning: AnsiPen()..magenta(),
      TalkerLogType.verbose: AnsiPen()..white(),
      TalkerLogType.debug: AnsiPen()..green()
    }, titles: {
      TalkerLogType.critical: 'critical'.toUpperCase(),
      TalkerLogType.error: 'error'.toUpperCase(),
      TalkerLogType.info: 'info'.toUpperCase(),
      TalkerLogType.warning: 'warning'.toUpperCase(),
      TalkerLogType.verbose: 'verbose'.toUpperCase(),
      TalkerLogType.debug: 'debug'.toUpperCase()
    }),
  );

  // Private constructor
  LoggerUtil._internal();

  // Public factory method to provide access to the singleton instance
  factory LoggerUtil() {
    return _instance;
  }
  Talker get talker => talkerLogger;

  // Method to get the database instance

   debugData(dynamic message, [Object? error, StackTrace? stackTrace]) {
    talkerLogger.debug(message, error, stackTrace);
  }

  errorData(dynamic message, [Object? error, StackTrace? stackTrace]) {
    talkerLogger.error(message, error, stackTrace);
  }

  infoData(dynamic message, [Object? error, StackTrace? stackTrace]) {
    talkerLogger.info(message, error, stackTrace);
  }

  criticalData(dynamic message, [Object? error, StackTrace? stackTrace]) {
    talkerLogger.critical(message, error, stackTrace);
  }

  warningData(dynamic message, [Object? error, StackTrace? stackTrace]) {
    talkerLogger.warning(message, error, stackTrace);
  }

  verboseData(String message, [Object? error, StackTrace? stackTrace]) {
    talkerLogger.verbose(message, error, stackTrace);
  }
}

class ColoredLoggerFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final coloredMsg =
        msg.split('\n').map((e) => details.pen.write(e)).toList().join('\n');
    return coloredMsg;
  }
}
