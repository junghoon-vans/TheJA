import 'package:flutter/material.dart';
import 'package:theja/data.dart';
import 'package:theja/models/models.dart';
import 'package:theja/widgets/widgets.dart';

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
      onReorder: _onReorder,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: List.generate(
        vehicleList.length,
        (index) {
          return CollectionCard(
            vehicleList,
            index,
            Key('$index'),
          );
        },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final Vehicle item = vehicleList.removeAt(oldIndex);
        vehicleList.insert(newIndex, item);
      },
    );
  }
}
