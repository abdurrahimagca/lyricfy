

import 'package:flutter/material.dart';

Future<void> okPopBuilder(BuildContext context, String title, String message) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("$title successful"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // close the dialog
            },
          ),
        ],
      );
    },
  );
}
