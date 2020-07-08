import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/fab/fab.dart';
import 'package:theja/blocs/tab/tab.dart';
import 'package:theja/models/models.dart';

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final AppTab appTab;

  const TabItem({Key key, this.text, this.icon, this.isSelected, this.appTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 27,
              color: isSelected ? Colors.blue.shade900 : Colors.grey.shade400,
            ),
            Text(
              text,
              style: TextStyle(
                  color:
                      isSelected ? Colors.blue.shade900 : Colors.grey.shade400,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 12),
            )
          ],
        ),
      ),
      onTap: () {
        BlocProvider.of<TabBloc>(context).add(TabUpdated(appTab));
        BlocProvider.of<FabBloc>(context).add(FabUpdated(AppFab.normal));
      },
    );
  }
}
