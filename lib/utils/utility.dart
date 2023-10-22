import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget showLoader(BuildContext context) {
  return Platform.isIOS
      ? CupertinoActivityIndicator(
          color: Theme.of(context).colorScheme.secondary,
        )
      : SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
}



showSnackBar(BuildContext context, String? message, [bool isError = false]) {
  if (message == null || message.isEmpty) return;

  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.grey[800],
      content: Text(
        message,
        style: TextStyle(color: isError ? Colors.yellow[300] : Colors.white),
      ),
      duration: Duration(milliseconds: isError ? 3000 : 3000),
    ),
  );
}
