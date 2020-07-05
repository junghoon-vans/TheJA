import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/fab/fab.dart';
import 'package:theja/models/fab.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FabBloc, AppFab>(
      builder: (context, isFabExpand) {
        return FloatingActionButton(
          onPressed: () => isFabExpand == AppFab.normal
              ? BlocProvider.of<FabBloc>(context).add(FabUpdated(AppFab.expand))
              : BlocProvider.of<FabBloc>(context)
                  .add(FabUpdated(AppFab.normal)),
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.add),
          ),
          elevation: 4.0,
        );
      },
    );
  }
}
