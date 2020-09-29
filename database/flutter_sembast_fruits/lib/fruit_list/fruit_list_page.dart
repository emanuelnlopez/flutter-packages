import 'package:flutter/material.dart';
import 'package:flutter_sembast_fruits/fruit_list/fruit_list_bloc.dart';
import 'package:flutter_sembast_fruits/data/fruit.dart';

class FruitListPage extends StatefulWidget {
  FruitListPage({Key key}) : super(key: key);

  @override
  _FruitListPageState createState() => _FruitListPageState();
}

class _FruitListPageState extends State<FruitListPage> {
  FruitListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = FruitListBloc();
  }

  Row _buildUpdateDeleteButtons(Fruit displayedFruit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => _bloc.updateWithRandomFruit(displayedFruit),
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () => _bloc.deleteFruit(displayedFruit),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sembast Fruits App'),
      ),
      body: StreamBuilder<List<Fruit>>(
        stream: _bloc.fruitListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            final fruits = snapshot.data;
            return ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                final displayedFruit = fruits[index];
                return ListTile(
                  subtitle: Text(
                      displayedFruit.isSweet ? 'Very sweet!' : 'Sooo sour!'),
                  title: Text(displayedFruit.name),
                  trailing: _buildUpdateDeleteButtons(displayedFruit),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bloc.addRandomFruit,
        child: Icon(Icons.add),
      ),
    );
  }
}
