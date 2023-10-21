import 'package:flutter/material.dart';


@immutable
class AppTheme {
  const AppTheme._();

  static ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
    if (isDarkTheme) {
      return ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
            background: Colors.black, primary: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green))),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
        textTheme: const TextTheme(
          titleSmall: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
        canvasColor: Colors.grey,
        dropdownMenuTheme: DropdownMenuThemeData(
            textStyle: const TextStyle(color: Colors.white),
            inputDecorationTheme:
                const InputDecorationTheme(fillColor: Colors.grey),
            menuStyle: MenuStyle(
                shadowColor: MaterialStateProperty.all(Colors.green),
                backgroundColor: MaterialStateProperty.all(Colors.grey))),
       
      );
    } else {
      return ThemeData(
          useMaterial3: true,
          primaryColor: Colors.amber,
          scaffoldBackgroundColor: Colors.white,
          buttonTheme: const ButtonThemeData(
            focusColor: Colors.blue,
            buttonColor: Colors.orange,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green))),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
          textTheme: const TextTheme(
            titleSmall: TextStyle(color: Colors.black),
            titleMedium: TextStyle(color: Colors.black),
            titleLarge: TextStyle(color: Colors.black),
          ),
         
          dropdownMenuTheme: const DropdownMenuThemeData(
              textStyle: TextStyle(color: Colors.white)));
    }
  }
}
