import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/tab/tab.dart';
import 'package:theja/models/tab.dart';
import 'package:theja/widgets/widgets.dart';

final tabs = ['Home', 'List'];

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Container(
          margin: EdgeInsets.only(left: 15.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TabItem(
                text: tabs[0],
                icon: Icons.home,
                isSelected: activeTab == AppTab.home,
                onTap: () => BlocProvider.of<TabBloc>(context)
                    .add(TabUpdated(AppTab.home)),
              ),
              SizedBox(
                width: 50.0,
              ),
              TabItem(
                text: tabs[1],
                icon: Icons.list,
                isSelected: activeTab == AppTab.list,
                onTap: () => BlocProvider.of<TabBloc>(context)
                    .add(TabUpdated(AppTab.list)),
              ),
            ],
          ),
        );
      },
    );
  }
}
