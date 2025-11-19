import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/features/game/domain/enums/game_mode.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/opponent.dart';

part 'game_settings.freezed.dart';

@freezed
abstract class GameSettings with _$GameSettings {
  const factory GameSettings({
    @Default(GridSize.normal) GridSize gridSize,
    @Default(Opponent.friend) Opponent opponent,
    @Default(BotDifficulty.easy) BotDifficulty botDifficulty,
    @Default(GameMode.normal) GameMode gameMode,
  }) = _GameSettings;
}
