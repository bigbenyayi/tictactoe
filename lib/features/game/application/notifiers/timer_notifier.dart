import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/application/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';

part 'timer_notifier.g.dart';

@riverpod
class TimerNotifier extends _$TimerNotifier {
  Timer? _timer;

  @override
  int? build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return null;
  }

  void startTimer() {
    final GameSettings settings = ref.read(gameSettingsProvider);
    _timer?.cancel();
    if (settings.gameMode.isBlitz) {
      const int duration = 2000; // 2 seconds in milliseconds
      final int endTime = DateTime.now().millisecondsSinceEpoch + duration;
      state = duration;
      _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer tick) {
        final int now = DateTime.now().millisecondsSinceEpoch;
        final int remaining = endTime - now;

        if (remaining <= 0) {
          state = 0;
          _handleTimeout();
        } else {
          state = remaining;
        }
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    state = null;
  }

  void _handleTimeout() {
    _timer?.cancel();
    ref.read(gameProvider.notifier).handleTimeout();
  }
}
