import 'package:flutter/material.dart';
import 'package:flutter_sembast_fruits/fruit_list/fruit_list_page.dart';

void main() {
  runApp(FruitsApp());
}

class FruitsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sembast Fruits App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FruitListPage(),
    );
  }
}
