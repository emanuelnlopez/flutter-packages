import 'package:flutter/material.dart';
import 'package:flutter_provider_flavors/counter.dart';
import 'package:flutter_provider_flavors/pages/home_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<Counter>(
        create: (context) => Counter(),
        child: HomePage(),
      ),
    );
  }
}
