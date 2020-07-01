import 'package:flutter/material.dart';
import 'package:theja/widgets/widgets.dart';

class Bottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomState();
}

final tabs = ['Home', 'List'];

class _BottomState extends State<Bottom> {
  int selectedIndex = 0;

  void updateTabSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TabItem(
            text: tabs[0],
            icon: Icons.home,
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
          ),
          SizedBox(
            width: 50.0,
          ),
          TabItem(
            text: tabs[1],
            icon: Icons.list,
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}
