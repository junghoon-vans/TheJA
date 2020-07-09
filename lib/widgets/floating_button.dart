import 'package:flutter/material.dart';
import 'package:theja/models/enums.dart';
import 'package:theja/utils/collection_db_helper.dart';
import 'package:theja/widgets/widgets.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        PopUpForm().create(context, PopUpFormMode.add).then((value) =>
            value != null
                ? CollectionDBHelper.db.insert(context, value)
                : null);
      },
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Icon(Icons.add),
      ),
      elevation: 4.0,
    );
  }
}
