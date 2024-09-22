import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/features/theme/theme.dart';
import 'package:todo/src/features/todo_list/screens/todo_list_screen.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final themeProvider = ThemeProvider();
        themeProvider.loadTheme();
        return themeProvider;
      },
      builder: (context, _) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Cerrencies List',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: const ToDoListScreen(),
            );
          },
        );
      },
    );
  }
}
