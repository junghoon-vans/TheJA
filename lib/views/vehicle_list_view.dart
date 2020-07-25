import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/items/items.dart';
import 'package:theja/models/models.dart';

class VehicleListView extends StatefulWidget {
  _VehicleListView createState() => _VehicleListView();
}

class _VehicleListView extends State<VehicleListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, List<Vehicle>>(
      builder: (context, vehicleList) {
        return ListView(
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
      },
    );
  }
}
