import 'package:catalog_jogos/core/preferences/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preferencesServiceProvider = Provider((ref) => PreferencesService());

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final service = ref.watch(preferencesServiceProvider);
  return ThemeNotifier(service);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final PreferencesService _service;

  ThemeNotifier(this._service) : super(ThemeMode.dark) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDark = await _service.getThemeMode();
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      await _service.setThemeMode(false);
    } else {
      state = ThemeMode.dark;
      await _service.setThemeMode(true);
    }
  }
}
