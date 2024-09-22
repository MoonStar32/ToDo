import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/features/theme/theme.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Switch(
          value: themeProvider.isBarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        );
      },
    );
  }
}
