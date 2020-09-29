import 'dart:async';

import 'package:flutter_sembast_fruits/core/bloc.dart';
import 'package:flutter_sembast_fruits/data/fruit.dart';
import 'package:flutter_sembast_fruits/data/fruit_dao.dart';
import 'package:flutter_sembast_fruits/data/random_fruit_generator.dart';

class FruitListBloc extends Bloc {
  FruitListBloc() {
    _fruitDao = FruitDao();
    loadFruits();
  }

  final _fruitListController = StreamController<List<Fruit>>.broadcast();

  FruitDao _fruitDao;
  List<Fruit> _fruitList;

  Stream<List<Fruit>> get fruitListStream => _fruitListController.stream;

  @override
  void dispose() {
    _fruitListController.close();
  }

  Future<void> addRandomFruit() async {
    await _fruitDao.insert(
      RandomFruitGenerator.getRandomFruit(),
    );
    loadFruits();
  }

  Future<void> deleteFruit(Fruit fruit) async {
    await _fruitDao.delete(fruit);
    loadFruits();
  }

  Future<void> loadFruits() async {
    _fruitListController.add(null);
    _fruitList = await _fruitDao.getAllSortedByName();
    _fruitListController.add(_fruitList);
  }

  Future<void> updateWithRandomFruit(Fruit fruit) async {
    final newFruit = RandomFruitGenerator.getRandomFruit();
    newFruit.id = fruit.id;
    await _fruitDao.update(newFruit);
    loadFruits();
  }
}
