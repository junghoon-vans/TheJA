import 'package:flutter/material.dart';

class PopUpForm {
  TextEditingController textEditingController = TextEditingController();

  Future<String> create(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('컬렉션 추가'),
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
