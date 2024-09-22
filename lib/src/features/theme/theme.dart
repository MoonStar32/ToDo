import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isBarkMode => themeMode == ThemeMode.dark;

  Future<void> toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('themeMode', themeMode.index);
  }

  Future<void> loadTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final saveThemeIndex = preferences.getInt('themeMode');
    if (saveThemeIndex != null) {
      themeMode = ThemeMode.values[saveThemeIndex];
      notifyListeners();
    }
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
    hintColor: Colors.grey,
    primaryColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      tileColor: Color.fromARGB(255, 248, 220, 255),
    ),
  );
  static final darkTheme = ThemeData(
    hintColor: Colors.white,
    primaryColor: const Color.fromARGB(255, 34, 39, 85),
    scaffoldBackgroundColor: const Color.fromARGB(255, 18, 21, 43),
    shadowColor: const Color.fromARGB(255, 36, 226, 255),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 34, 39, 85),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      tileColor: Color.fromARGB(255, 34, 39, 85),
    ),
  );
}
