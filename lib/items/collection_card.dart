import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:theja/models/models.dart';
import 'package:theja/route.dart';
import 'package:theja/utils/collection_db_helper.dart';

class CollectionCard extends StatefulWidget {
  final int index;
  final Key key;
  final List<Collection> listItems;

  CollectionCard(this.listItems, this.index, this.key);

  @override
  _CollectionCard createState() => _CollectionCard();
}

class _CollectionCard extends State<CollectionCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: createCard(context, widget),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {},
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => CollectionDBHelper.db
              .delete(context, widget.listItems[widget.index].id, widget.index),
        ),
      ],
    );
  }
}

createCard(context, widget) {
  return Card(
    margin: EdgeInsets.all(4),
    color: Colors.white,
    child: InkWell(
      splashColor: Colors.blue,
      onTap: () {
        Navigator.pushNamed(context, Routes.list,
            arguments: widget.listItems[widget.index].id);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget.listItems[widget.index].name}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16),
                        textAlign: TextAlign.left,
                        maxLines: 5,
                      ),
                    ),
                  ],
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
