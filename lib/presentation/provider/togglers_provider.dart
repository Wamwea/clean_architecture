import 'package:flutter_riverpod/flutter_riverpod.dart';

class Toggle extends StateNotifier<bool> {
  Toggle() : super(true);

  setTrue() {
    state = true;
  }

  setFalse() {
    state = false;
  }
}

final toggleProvider = StateNotifierProvider<Toggle, bool>((ref) {
  return Toggle();
});
