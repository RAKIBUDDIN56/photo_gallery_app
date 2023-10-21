import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'app/app.dart';
import 'domain/models/photos_list_response.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());

  runApp(const App());
}
