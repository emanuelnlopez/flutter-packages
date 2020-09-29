import 'package:meta/meta.dart';

class Fruit {
  Fruit({
    @required this.name,
    @required this.isSweet,
  });

  int id;
  final bool isSweet;
  final String name;

  Map<String, dynamic> toMap() => {
        'name': name,
        'isSweet': isSweet,
      };

  static Fruit fromMap(Map<String, dynamic> map) => Fruit(
        name: map['name'],
        isSweet: map['isSweet'],
      );
}
