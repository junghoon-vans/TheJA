import 'package:flutter/material.dart';

class List extends StatefulWidget {
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.directions_bus),
            title: Text('2'),
            subtitle: Text('호봉골'),
            trailing: Icon(Icons.menu),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.directions_subway),
            title: Text('1호선'),
            subtitle: Text('광명역'),
            trailing: Icon(Icons.menu),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text('걷기'),
            trailing: Icon(Icons.menu),
          ),
        ),
      ],
    );
  }
}
