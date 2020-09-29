import 'package:flutter_sembast_fruits/data/app_database.dart';
import 'package:flutter_sembast_fruits/data/fruit.dart';
import 'package:sembast/sembast.dart';

class FruitDao {
  static const String FRUIT_STORE_NAME = 'fruits';

  final _fruitStore = intMapStoreFactory.store(FRUIT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Fruit fruit) async {
    await _fruitStore.add(
      await _db,
      fruit.toMap(),
    );
  }

  Future update(Fruit fruit) async {
    final finder = Finder(
      filter: Filter.byKey(fruit.id),
    );

    await _fruitStore.update(
      await _db,
      fruit.toMap(),
      finder: finder,
    );
  }

  Future delete(Fruit fruit) async {
    final finder = Finder(
      filter: Filter.byKey(fruit.id),
    );

    await _fruitStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Fruit>> getAllSortedByName() async {
    final finder = Finder(
      sortOrders: [
        SortOrder('name'),
      ],
    );

    final recordSnapshots = await _fruitStore.find(
      await _db,
      finder: finder,
    );

    return recordSnapshots.map((snapshot) {
      final fruit = Fruit.fromMap(snapshot.value);
      fruit.id = snapshot.key;
      return fruit;
    }).toList();
  }
}
