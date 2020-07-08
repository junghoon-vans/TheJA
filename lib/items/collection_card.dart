import 'package:flutter/material.dart';
import 'package:theja/models/models.dart';
import 'package:theja/route.dart';

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
    return Card(
      margin: EdgeInsets.all(4),
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          Navigator.pushNamed(context, Routes.detail);
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
                          '${widget.listItems[widget.index]}',
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
}
