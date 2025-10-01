import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(AppConstants.themeModeKey) ?? false;
      state = isDark;
    } catch (e) {
      // If loading fails, keep default theme
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = !state;
      await prefs.setBool(AppConstants.themeModeKey, state);
    } catch (e) {
      // If saving fails, revert state
      state = !state;
    }
  }
}