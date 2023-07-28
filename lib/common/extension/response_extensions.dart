import 'package:http/http.dart';

extension ResponseExtensions on Response {
  String printError() {
    final builder = StringBuffer()
      ..write(statusCode)
      ..write(errorSeparator)
      ..write(reasonPhrase)
      ..write(errorSeparator)
      ..write(body);

    return builder.toString();
  }
}

const String errorSeparator = ": ";
