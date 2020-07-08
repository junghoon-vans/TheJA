import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/tab/tab.dart';
import 'package:theja/items/items.dart';
import 'package:theja/models/tab.dart';

final tabs = ['Home', 'Collections'];

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 180,
              child: TabItem(
                text: tabs[0],
                icon: Icons.home,
                isSelected: activeTab == AppTab.home,
                appTab: AppTab.home,
              ),
            ),
            SizedBox(
              width: 50.0,
            ),
            Container(
              width: 180,
              child: TabItem(
                text: tabs[1],
                icon: Icons.list,
                isSelected: activeTab == AppTab.list,
                appTab: AppTab.list,
              ),
            ),
          ],
        );
      },
    );
  }
}
