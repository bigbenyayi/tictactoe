import 'dart:math';

import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/domain/services/winner_checker_service.dart';

class BotService {
  final WinnerCheckerService winnerCheckerService;

  BotService(this.winnerCheckerService);

  int getMove(Game game, GridSize gridSize, BotDifficulty? botDifficulty) {
    switch (botDifficulty!) {
      case BotDifficulty.easy:
        return _getEasyMove(game, gridSize);
      case BotDifficulty.medium:
        return _getMediumMove(game, gridSize);
      case BotDifficulty.hard:
        return _getBestMove(game, gridSize);
    }
  }

  int _getEasyMove(Game game, GridSize gridSize) {
    final List<int> availableMoves = _getAvailableMoves(game.board);
    if (availableMoves.isEmpty) {
      return -1;
    }

    final List<int> opponentMoves = <int>[];
    for (int i = 0; i < game.board.length; i++) {
      if (game.board[i].isX) {
        opponentMoves.add(i);
      }
    }

    if (opponentMoves.isEmpty) {
      return availableMoves[Random().nextInt(availableMoves.length)];
    }

    final Set<int> adjacentMoves = <int>{};
    final int dimension = gridSize.dimension;

    for (final int move in opponentMoves) {
      final int row = move ~/ dimension;
      final int col = move % dimension;

      for (int r = row - 1; r <= row + 1; r++) {
        for (int c = col - 1; c <= col + 1; c++) {
          if (r < 0 || r >= dimension || c < 0 || c >= dimension) continue;
          if (r == row && c == col) continue;

          final int neighborIndex = r * dimension + c;
          if (game.board[neighborIndex].isNone) {
            adjacentMoves.add(neighborIndex);
          }
        }
      }
    }

    if (adjacentMoves.isNotEmpty) {
      final List<int> moveList = adjacentMoves.toList();
      return moveList[Random().nextInt(moveList.length)];
    } else {
      return availableMoves[Random().nextInt(availableMoves.length)];
    }
  }

  int _getMediumMove(Game game, GridSize gridSize) {
    final int? winningMove = _findWinningMove(game, Player.o, gridSize);
    if (winningMove != null) return winningMove;

    final int? blockingMove = _findWinningMove(game, Player.x, gridSize);
    if (blockingMove != null) return blockingMove;

    return _getEasyMove(game, gridSize);
  }

  int? _findWinningMove(Game game, Player player, GridSize gridSize) {
    final List<int> availableMoves = _getAvailableMoves(game.board);
    for (final int move in availableMoves) {
      final List<Player> tempBoard = List<Player>.from(game.board);
      tempBoard[move] = player;
      if (winnerCheckerService.checkWinner(tempBoard, gridSize) != null) {
        return move;
      }
    }
    return null;
  }

  int _getBestMove(Game game, GridSize gridSize) {
    int bestMove = -1;
    int bestScore = -10000;

    for (final int move in _getAvailableMoves(game.board)) {
      final List<Player> tempBoard = List<Player>.from(game.board);
      tempBoard[move] = Player.o; // Bot's move
      final Game tempGame = game.copyWith(board: tempBoard, currentPlayer: Player.x);

      final int score = _minimax(tempGame, 0, false, gridSize);

      if (score > bestScore) {
        bestScore = score;
        bestMove = move;
      }
    }
    return bestMove != -1 ? bestMove : _getEasyMove(game, gridSize);
  }

  int _minimax(Game game, int depth, bool isMaximizing, GridSize gridSize) {
    final List<int>? winnerLine = winnerCheckerService.checkWinner(game.board, gridSize);
    if (winnerLine != null) {
      final Player winner = game.board[winnerLine.first];
      if (winner .isO) return 1000 - depth;
      if (winner .isX) return -1000 + depth;
    }

    if (_getAvailableMoves(game.board).isEmpty) return 0;

    if (gridSize.dimension > 3) {
      return _evaluateBoard(game, gridSize);
    }

    if (isMaximizing) {
      int bestScore = -10000;
      for (final int move in _getAvailableMoves(game.board)) {
        final List<Player> tempBoard = List<Player>.from(game.board);
        tempBoard[move] = Player.o;
        final Game tempGame = game.copyWith(board: tempBoard, currentPlayer: Player.x);
        bestScore = max(bestScore, _minimax(tempGame, depth + 1, false, gridSize));
      }
      return bestScore;
    } else {
      int bestScore = 10000;
      for (final int move in _getAvailableMoves(game.board)) {
        final List<Player> tempBoard = List<Player>.from(game.board);
        tempBoard[move] = Player.x;
        final Game tempGame = game.copyWith(board: tempBoard, currentPlayer: Player.o);
        bestScore = min(bestScore, _minimax(tempGame, depth + 1, true, gridSize));
      }
      return bestScore;
    }
  }

  int _evaluateBoard(Game game, GridSize gridSize) {
    int score = 0;
    final int winCondition = gridSize.dimension > 3 ? 4 : 3;

    // Evaluate rows, columns, and diagonals
    score += _evaluateLines(game.board, gridSize.dimension, winCondition);

    return score;
  }

  int _evaluateLines(List<Player> board, int gridSize, int winCondition) {
    int score = 0;
    // Row scores
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c <= gridSize - winCondition; c++) {
        final List<Player> line = List<Player>.generate(winCondition, (int i) => board[r * gridSize + c + i]);
        score += _getLineScore(line);
      }
    }
    // Column scores
    for (int c = 0; c < gridSize; c++) {
      for (int r = 0; r <= gridSize - winCondition; r++) {
        final List<Player> line = List<Player>.generate(winCondition, (int i) => board[(r + i) * gridSize + c]);
        score += _getLineScore(line);
      }
    }
    // Diagonal scores
    for (int r = 0; r <= gridSize - winCondition; r++) {
      for (int c = 0; c <= gridSize - winCondition; c++) {
        final List<Player> line = List<Player>.generate(winCondition, (int i) {
          return board[(r + i) * gridSize + c + i];
        });
        score += _getLineScore(line);
      }
    }
    for (int r = 0; r <= gridSize - winCondition; r++) {
      for (int c = winCondition - 1; c < gridSize; c++) {
        final List<Player> line = List<Player>.generate(winCondition, (int i) {
          return board[(r + i) * gridSize + c - i];
        });
        score += _getLineScore(line);
      }
    }
    return score;
  }

  int _getLineScore(List<Player> line) {
    final int botCount = line.where((Player p) => p .isO).length;
    final int playerCount = line.where((Player p) => p .isX).length;

    if (botCount > 0 && playerCount > 0) return 0; // Mixed line
    if (botCount == 0 && playerCount == 0) return 0; // Empty line

    if (botCount > 0) {
      if (botCount == 4) return 5000;
      if (botCount == 3) return 100;
      if (botCount == 2) return 10;
      if (botCount == 1) return 1;
    } else if (playerCount > 0) {
      if (playerCount == 4) return -10000;
      if (playerCount == 3) return -200;
      if (playerCount == 2) return -20;
      if (playerCount == 1) return -2;
    }
    return 0;
  }

  List<int> _getAvailableMoves(List<Player> board) {
    final List<int> moves = <int>[];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == Player.none) moves.add(i);
    }
    return moves;
  }
}
