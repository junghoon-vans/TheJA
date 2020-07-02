import 'package:flutter/material.dart';
import 'package:theja/data.dart';
import 'package:theja/models/models.dart';

class CollectionView extends StatefulWidget {
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: const EdgeInsets.all(8),
      children: vehicleList
          .map(
            (item) => ListTile(
              key: Key("$item"),
              title: Text("$item"),
              trailing: Icon(Icons.menu),
            ),
          )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(
          () {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final Vehicle item = vehicleList.removeAt(oldIndex);
            vehicleList.insert(newIndex, item);
          },
        );
      },
    );
  }
}
