import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  Contact({
    @required this.age,
    @required this.name,
  });

  @HiveField(0)
  final int age;

  @HiveField(1)
  final String name;
}
