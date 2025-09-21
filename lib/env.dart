// lib/env.dart
class Env {
  static late final String flavor;          // "dev" | "prod"
  static late final double codTolerance;    // dev=0.5, prod=1.0 by default

  static void init() {
    flavor = const String.fromEnvironment('FLUTTER_FLAVOR', defaultValue: 'prod');

    // Leave empty default so we can detect "not provided"
    final tolStr = const String.fromEnvironment('COD_TOLERANCE', defaultValue: '');
    final tolParsed = double.tryParse(tolStr);

    codTolerance = tolParsed ?? (flavor == 'dev' ? 0.5 : 1.0);

    // TEMP debug
    // ignore: avoid_print
    print('[Env] flavor=$flavor  codTolerance=$codTolerance  (raw COD_TOLERANCE="$tolStr")');
  }

  static bool get isDev => flavor == 'dev';
  static bool get isProd => flavor == 'prod';
}
