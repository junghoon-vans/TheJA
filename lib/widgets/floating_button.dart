import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/fab/fab.dart';
import 'package:theja/models/fab.dart';
import 'package:theja/utils/collection_db_helper.dart';
import 'package:theja/widgets/widgets.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FabBloc, AppFab>(
      builder: (context, isFabExpand) {
        return FloatingActionButton(
          onPressed: () {
            PopUpForm().create(context).then((value) =>
                value != null ?? CollectionDBHelper().insert(context, value));
          },
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
