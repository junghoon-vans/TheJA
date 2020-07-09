import 'package:flutter/material.dart';
import 'package:theja/models/enums.dart';
import 'package:theja/strings.dart';

class PopUpForm {
  TextEditingController textEditingController = TextEditingController();

  Future<String> create(BuildContext context, PopUpFormMode mode) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mode == PopUpFormMode.add
              ? Strings.collectionAdd
              : Strings.collectionEdit),
          content: TextField(
            controller: textEditingController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('Submit'),
              onPressed: () => Navigator.of(context)
                  .pop(textEditingController.text.toString()),
            )
          ],
        );
      },
    );
  }
}
