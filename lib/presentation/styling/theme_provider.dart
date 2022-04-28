import 'package:clean_architecture/data/data_sources/local_data_source.dart';
import 'package:clean_architecture/injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/local_repository.dart';

class DarkMode extends StateNotifier<bool> {
  DarkMode() : super(true);

  getTheme() async {
    state = await locator<LocalRepository>().getTheme();
  }

  toggleDarkMode() async {
    state = await locator<LocalRepository>().toggleTheme();
  }
}

final darkModeProvider = StateNotifierProvider<DarkMode, bool>((ref) {
  return DarkMode();
});
