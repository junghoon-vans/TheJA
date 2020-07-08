import 'package:flutter/material.dart';
import 'package:theja/data.dart';
import 'package:theja/items/items.dart';
import 'package:theja/models/models.dart';

class VehicleListView extends StatefulWidget {
  _VehicleListView createState() => _VehicleListView();
}

class _VehicleListView extends State<VehicleListView> {
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
          return VehicleListCard(
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
