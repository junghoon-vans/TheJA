import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/fab/fab.dart';
import 'package:theja/models/fab.dart';

class ExpandView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FabBloc, AppFab>(builder: (context, isFabExpand) {
      return Align(
        alignment: FractionalOffset.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: isFabExpand == AppFab.expand
              ? MediaQuery.of(context).size.height / 5
              : 10.0,
          width: isFabExpand == AppFab.expand
              ? MediaQuery.of(context).size.height
              : 10.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  isFabExpand == AppFab.expand ? 0.0 : 300.0),
              color: Colors.white),
        ),
      );
    });
  }
}
