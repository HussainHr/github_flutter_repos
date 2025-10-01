import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNotifierProvider);

    return IconButton(
      icon: Icon(
        isDarkTheme ? Icons.light_mode : Icons.dark_mode,
      ),
      tooltip: isDarkTheme ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: () {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
    );
  }
}