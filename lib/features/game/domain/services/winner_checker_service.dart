import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';

class WinnerCheckerService {
  List<int>? checkWinner(List<Player> board, GridSize gridSize) {
    final int winCondition = gridSize.winLength;

    for (int i = 0; i < board.length; i++) {
      if (board[i].isNone) continue;

      final int row = i ~/ gridSize.dimension;
      final int col = i % gridSize.dimension;

      if (col <= gridSize.dimension - winCondition) {
        final List<int> line = List<int>.generate(winCondition, (int j) => i + j);
        if (line.every((int index) => board[index] == board[i])) return line;
      }
      if (row <= gridSize.dimension - winCondition) {
        final List<int> line = List<int>.generate(winCondition, (int j) => i + j * gridSize.dimension);
        if (line.every((int index) => board[index] == board[i])) return line;
      }
      if (row <= gridSize.dimension - winCondition && col <= gridSize.dimension - winCondition) {
        final List<int> line = List<int>.generate(winCondition, (int j) => i + j * (gridSize.dimension + 1));
        if (line.every((int index) => board[index] == board[i])) return line;
      }
      if (row <= gridSize.dimension - winCondition && col >= winCondition - 1) {
        final List<int> line = List<int>.generate(winCondition, (int j) => i + j * (gridSize.dimension - 1));
        if (line.every((int index) => board[index] == board[i])) return line;
      }
    }
    return null;
  }
}
