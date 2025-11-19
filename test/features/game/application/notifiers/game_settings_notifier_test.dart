import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/features/game/domain/enums/game_mode.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/opponent.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('GameSettingsNotifier', () {
    test('initial state is default GameSettings', () {
      final GameSettings state = container.read(gameSettingsProvider);
      expect(state, const GameSettings());
    });

    test('setGridSize updates state', () {
      container.read(gameSettingsProvider.notifier).setGridSize(GridSize.large);
      expect(container.read(gameSettingsProvider).gridSize, GridSize.large);
    });

    test('setOpponent updates state', () {
      container.read(gameSettingsProvider.notifier).setOpponent(Opponent.friend);
      expect(container.read(gameSettingsProvider).opponent, Opponent.friend);
    });

    test('setBotDifficulty updates state', () {
      container.read(gameSettingsProvider.notifier).setBotDifficulty(BotDifficulty.hard);
      expect(container.read(gameSettingsProvider).botDifficulty, BotDifficulty.hard);
    });

    test('setGameMode updates state', () {
      container.read(gameSettingsProvider.notifier).setGameMode(GameMode.blitz);
      expect(container.read(gameSettingsProvider).gameMode, GameMode.blitz);
    });
  });
}
