import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Logger {
  Logger([Object? obj, String? name]) {
    _log(obj, _LogType.msg, name);
  }
  static bool enable = kDebugMode;

  static String prettyJSONString(response) {
    try {
      const encoder = JsonEncoder.withIndent("  ");
      return encoder.convert(response);
    } catch (e, st) {
      ex(e, st, 'Error while pretty printing JSON');
      return response;
    }
  }

  static PrettyDioLogger dioLogger() => PrettyDioLogger(
        logPrint: (o) => log(o.toString(), name: 'DIO'),
        request: true,
        responseBody: false,
        error: true,
        maxWidth: 120,
        // requestHeader: true,
        requestBody: true,
        // responseHeader: true,
      );

  static json(response, [String name = 'JSON']) {
    _log(prettyJSONString(response), _LogType.json, name);
  }

  static route(response, [String name = 'Route']) {
    _log(prettyJSONString(response), _LogType.route, name);
  }

  static ex(Object? error, [StackTrace? stackTrace, String? msg]) {
    if (error == null) return;
    const handler = _LogErrorHandler();
    _log(handler.handle(error, stackTrace, msg), _LogType.error, 'ex');
  }

  static void _log(Object? obj, _LogType type, [String? name]) {
    if (enable && obj != null) {
      final logData = _ANSIUtils(obj, name).colorLinesByType(type);
      log(logData, name: '\u276f_');
    }
  }
}

enum _LogType { msg, error, warning, json, route }

class _LogErrorHandler {
  const _LogErrorHandler();

  String handle(
    Object exception, [
    StackTrace? stackTrace,
    String? msg,
  ]) {
    if (exception is Error) {
      return ' ${_showMsg(msg)}${_showErr(exception)}${_showST(stackTrace)}';
    }
    if (exception is Exception) {
      return '${_showMsg(msg)}${_showEX(exception)}${_showST(stackTrace)}';
    }
    return '${_showMsg('$exception')}${_showST(stackTrace)}';
  }

  String _showST(StackTrace? st) {
    if (st == null || st == StackTrace.empty) return '';

    return '''
  \n--.${'--' * 40}
StackTrace:
$st
''';
  }

  String _showEX(Exception? ex) {
    if (ex == null) return '';
    return '''
 \n--.${'--' * 40}
$ex
''';
  }

  String _showErr(Error? err) {
    if (err == null) return '';
    return '''
$err
 \n--.${'--' * 40}
''';
  }

  String _showMsg(String? message) {
    if (message == null) return '';
    return message;
  }
}

class _ANSIUtils {
  const _ANSIUtils(this.object, this.name);

  final Object object;
  final String? name;

  String red(String text) => '\u001b[31m$text\u001b[0m';
  String brightRed(String text) => '\u001b[91m$text\u001b[0m';
  String green(String text) => '\u001b[32m$text\u001b[0m';
  String yellow(String text) => '\u001b[33m$text\u001b[0m';
  String white(String text) => '\u001b[37m$text\u001b[0m';
  String purple(String text) => '\u001b[35m$text\u001b[0m';

  List<String> _lines() {
    final n = name == null ? '' : '[$name]  ';
    final obj = '''
--°${'--' * 40}
$n$object
--°${'--' * 40}
''';

    return obj.split('\n');
  }

  String colorLinesByType(_LogType type) {
    final lines = _lines();
    return switch (type) {
      _LogType.msg => lines.map((e) => white(e)).join('\n'),
      _LogType.error => _colorError(),
      _LogType.json => lines.map((e) => green(e)).join('\n'),
      _LogType.warning => lines.map((e) => yellow(e)).join('\n'),
      _LogType.route => lines.map((e) => purple(e)).join('\n'),
    };
  }

  String _colorError() {
    final lines = _lines();
    final parsedLines = [];

    for (final line in lines) {
      if (line.contains('(package:')) {
        final split = line.split('(package:');
        final path = '(package:${split[1].trim()}';
        final msg = split[0].trim();

        parsedLines.add('${red(msg)} ${brightRed(path)}');
      } else {
        parsedLines.add(red(line));
      }
    }

    return parsedLines.join('\n');
  }
}
