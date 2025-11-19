import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';

part 'game.freezed.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    required List<Player> board,
    required Player currentPlayer,
    Player? winner,
    List<int>? winningLine,
    @Default(2000) int timer,
  }) = _Game;

  factory Game.initial(GameSettings settings) {
    return Game(
      board: List<Player>.filled(
        settings.gridSize.dimension * settings.gridSize.dimension,
        Player.none,
      ),
      currentPlayer: Player.x,
    );
  }
}
