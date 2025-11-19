import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/application/notifiers/timer_notifier.dart';
import 'package:tictactoe/features/game/application/providers/bot_service_provider.dart';
import 'package:tictactoe/features/game/application/providers/make_move_use_case_provider.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';

part 'game_notifier.g.dart';

@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  Game build() {
    final GameSettings settings = ref.watch(gameSettingsProvider);
    return Game.initial(settings);
  }

  void makeMove(int index) {
    if (state.board[index] != Player.none || state.winner != null) {
      return;
    }
    final GameSettings settings = ref.read(gameSettingsProvider);
    state = ref.read(makeMoveUseCaseProvider).call(state, index, settings.gridSize);
    ref.read(timerProvider.notifier).startTimer();
    if (settings.opponent.isBot  && state.winner == null) {
      _playBotMove();
    }
    if (state.winner != null) {
      ref.read(timerProvider.notifier).stopTimer();
    }
  }

  void resetGame() {
    final GameSettings settings = ref.read(gameSettingsProvider);
    state = Game.initial(settings);
    ref.read(timerProvider.notifier).startTimer();
  }

  void handleTimeout() {
    state = state.copyWith(winner: state.currentPlayer.isX ? Player.o : Player.x);
  }

  void _playBotMove() {
    final GameSettings settings = ref.read(gameSettingsProvider);
    final int botMove = ref.read(botServiceProvider).getMove(state, settings.gridSize, settings.botDifficulty);
    state = ref.read(makeMoveUseCaseProvider).call(state, botMove, settings.gridSize);
    if (state.winner != null) {
      ref.read(timerProvider.notifier).stopTimer();
    }
  }
}
