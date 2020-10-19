/// Run with:
/// flutter run --flavor dev -t lib/main.dart
/// flutter run --flavor staging -t lib/main_staging.dart
/// flutter run --flavor prod -t lib/main_prod.dart
/// NOTE: On iOS, we need to create a matching Xcode scheme

enum Flavor { dev, staging, prod }
