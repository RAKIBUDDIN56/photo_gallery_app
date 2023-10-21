import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../domain/models/file_response.dart';

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

Future<String> savePhoto(FileResponse response) async {
  try {
    String path = '';
    if (Platform.isAndroid) {
      path = "/storage/emulated/0/Download";
    } else if (Platform.isIOS) {
      path = (await getApplicationDocumentsDirectory()).path;
    } else {
      throw Exception('Platform not supported yet');
    }
    if (!await Directory(path).exists()) await Directory(path).create();
    String filePath = '$path/photo_${response.filename}.jpg';
    File file = File(filePath);
    int count = 1;
    while (await file.exists() == true) {
      filePath = '$path/image($count)${response.filename}.jpg';
      file = File(filePath);
      count++;
    }
    file = await file.writeAsBytes(response.fileBytes);

    return filePath;
  } catch (error) {
    debugPrint(error.toString());
    return "";
  }
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
