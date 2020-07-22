import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:theja/models/models.dart';

import 'package:theja/data.dart';
import 'package:theja/utils/vehicle_db_helper.dart';

class VehicleListCard extends StatefulWidget {
  final int index;
  final Key key;
  final List<Vehicle> listItems;

  VehicleListCard(this.listItems, this.index, this.key);

  @override
  _VehicleListCard createState() => _VehicleListCard();
}

class _VehicleListCard extends State<VehicleListCard> {
  @override
  Widget build(BuildContext context) {
    String collectionName = ModalRoute.of(context).settings.arguments;
    Vehicle vehicle = widget.listItems[widget.index];

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: _card(context, vehicle),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => VehicleDBHelper.db.delete(
            context: context,
            widgetIndex: widget.index,
            collectionName: collectionName,
            routeId: vehicle.routeId,
            stationId: vehicle.stationId,
          ),
        ),
      ],
    );
  }
}

_card(BuildContext context, Vehicle vehicle) {
  return Card(
    margin: EdgeInsets.all(4),
    color: Colors.white,
    child: InkWell(
      splashColor: Colors.blue,
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(
              _icon(vehicle.type),
              color: Colors.grey,
              size: 24.0,
            ),
          ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${vehicle.routeName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.left,
                          maxLines: 5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${vehicle.stationName}',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                          textAlign: TextAlign.left,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          arr1,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                          textAlign: TextAlign.left,
                          maxLines: 5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          arr2,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16),
                          textAlign: TextAlign.left,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.reorder,
              color: Colors.grey,
              size: 24.0,
            ),
          ),
        ],
      ),
    ),
  );
}

_icon(int type) {
  switch (VehicleType.values[type]) {
    case VehicleType.bus:
      return Icons.directions_bus;
    case VehicleType.train:
      return Icons.directions_subway;
    case VehicleType.walk:
      return Icons.directions_walk;
  }
}
