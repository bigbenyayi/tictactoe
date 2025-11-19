import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/domain/services/winner_checker_service.dart';

void main() {
  late WinnerCheckerService service;

  setUp(() {
    service = WinnerCheckerService();
  });

  group('WinnerCheckerService', () {
    test('returns null when there is no winner on empty board', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      final List<int>? result = service.checkWinner(board, GridSize.normal);
      expect(result, isNull);
    });

    test('detects row winner', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.x;
      board[1] = Player.x;
      board[2] = Player.x;
      final List<int>? result = service.checkWinner(board, GridSize.normal);
      expect(result, <int>[0, 1, 2]);
    });

    test('detects column winner', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.o;
      board[3] = Player.o;
      board[6] = Player.o;
      final List<int>? result = service.checkWinner(board, GridSize.normal);
      expect(result, <int>[0, 3, 6]);
    });

    test('detects diagonal winner', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.x;
      board[4] = Player.x;
      board[8] = Player.x;
      final List<int>? result = service.checkWinner(board, GridSize.normal);
      expect(result, <int>[0, 4, 8]);
    });

    test('detects winner in large grid (4 in a row)', () {
        final List<Player> board = List<Player>.filled(25, Player.none);
        board[0] = Player.x;
        board[1] = Player.x;
        board[2] = Player.x;
        board[3] = Player.x;

        final List<int>? result = service.checkWinner(board, GridSize.large);
        expect(result, <int>[0, 1, 2, 3]);
    });
  });
}
