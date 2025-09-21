/// lib/env.dart
class Env {
  static late final String flavor;          // "dev" | "prod"
  static late final double codTolerance;    // e.g. 0.10 (dev) vs 1.00 (prod)

  static void init() {
    flavor = const String.fromEnvironment('FLUTTER_FLAVOR', defaultValue: 'prod');
    const tol = String.fromEnvironment('COD_TOLERANCE', defaultValue: '1.0');
    codTolerance = double.tryParse(tol) ?? 1.0;
  }

  static bool get isDev => flavor == 'dev';
  static bool get isProd => flavor == 'prod';
}
