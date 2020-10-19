import 'package:flutter/material.dart';
import 'package:flutter_provider_flavors/app.dart';
import 'package:flutter_provider_flavors/flavor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<Flavor>.value(
      value: Flavor.dev,
      child: App(),
    ),
  );
}
