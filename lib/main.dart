import 'package:flutter/material.dart';
import 'package:theja/widget/bottom_tab.dart';

void main() => runApp(Theja());

class Theja extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThejaState();
}

class _ThejaState extends State<Theja> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TheJA"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.add),
          ),
          elevation: 4.0,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.white,
          child: Bottom(),
        ),
      ),
    );
  }
}
