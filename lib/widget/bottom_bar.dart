import 'package:flutter/material.dart';
import 'package:theja/widget/bottom_bar_item.dart';

class Bottom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomState();
  }
}

final tabs = ['Home', 'List', 'Map', 'Settings'];

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
      margin: EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(
            width: 50.0,
          ),
          TabItem(
            text: tabs[2],
            icon: Icons.map,
            isSelected: selectedIndex == 2,
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
            },
          ),
          TabItem(
            text: tabs[3],
            icon: Icons.settings,
            isSelected: selectedIndex == 3,
            onTap: () {
              setState(() {
                selectedIndex = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}
