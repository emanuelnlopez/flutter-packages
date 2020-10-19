import 'package:flutter/material.dart';
import 'package:flutter_provider_flavors/counter.dart';
import 'package:flutter_provider_flavors/flavor.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context, listen: false);
    final flavor = Provider.of<Flavor>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(flavor.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<Counter>(
              builder: (_, value, __) => Text(
                '${value.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
