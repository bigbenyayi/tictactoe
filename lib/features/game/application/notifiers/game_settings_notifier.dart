import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/features/game/domain/enums/game_mode.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/opponent.dart';

part 'game_settings_notifier.g.dart';

@riverpod
class GameSettingsNotifier extends _$GameSettingsNotifier {
  @override
  GameSettings build() {
    return const GameSettings();
  }

  void setGridSize(GridSize gridSize) {
    state = state.copyWith(gridSize: gridSize);
  }

  void setOpponent(Opponent opponent) {
    state = state.copyWith(opponent: opponent);
  }

  void setBotDifficulty(BotDifficulty botDifficulty) {
    state = state.copyWith(botDifficulty: botDifficulty);
  }

  void setGameMode(GameMode gameMode) {
    state = state.copyWith(gameMode: gameMode);
  }
}
