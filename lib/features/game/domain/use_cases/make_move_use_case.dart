import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/domain/services/winner_checker_service.dart';

class MakeMoveUseCase {
  final WinnerCheckerService winnerCheckerService;

  MakeMoveUseCase(this.winnerCheckerService);

  Game call(Game game, int index, GridSize gridSize) {
    if (game.board[index] == Player.none && game.winner == null) {
      final List<Player> newBoard = List<Player>.from(game.board);
      newBoard[index] = game.currentPlayer;

      final List<int>? winningLine = winnerCheckerService.checkWinner(newBoard, gridSize);
      Player? winner = winningLine != null ? newBoard[winningLine[0]] : null;

      if (winner == null && !newBoard.contains(Player.none)) {
        winner = Player.none;
      }

      final Game newGame = game.copyWith(
        board: newBoard,
        currentPlayer: game.currentPlayer.isX ? Player.o : Player.x,
        winner: winner,
        winningLine: winningLine,
      );
      return newGame;
    }
    return game;
  }
}
