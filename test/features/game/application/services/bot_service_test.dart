import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/application/services/bot_service.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/domain/services/winner_checker_service.dart';

void main() {
  late BotService botService;
  late WinnerCheckerService winnerCheckerService;

  setUp(() {
    winnerCheckerService = WinnerCheckerService();
    botService = BotService(winnerCheckerService);
  });

  group('BotService', () {
    test('easy mode returns a valid move', () {
      final Game game = Game.initial(const GameSettings());
      final int move = botService.getMove(game, GridSize.normal, BotDifficulty.easy);
      
      expect(move, inInclusiveRange(0, 8));
      expect(game.board[move], Player.none);
    });

    test('medium mode blocks immediate threat', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.x;
      board[1] = Player.x;
      
      final Game game = Game.initial(const GameSettings()).copyWith(board: board, currentPlayer: Player.o);
      
      final int move = botService.getMove(game, GridSize.normal, BotDifficulty.medium);
      expect(move, 2);
    });

    test('medium mode takes winning move', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.o;
      board[1] = Player.o;
      board[3] = Player.x;
      board[4] = Player.x;
      
      final Game game = Game.initial(const GameSettings()).copyWith(board: board, currentPlayer: Player.o);
      
      final int move = botService.getMove(game, GridSize.normal, BotDifficulty.medium);
      expect(move, 2);
    });

    test('hard mode blocks threat', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.x;
      board[1] = Player.x;
      board[4] = Player.o;
      
      final Game game = Game.initial(const GameSettings()).copyWith(board: board, currentPlayer: Player.o);
      
      final int move = botService.getMove(game, GridSize.normal, BotDifficulty.hard);
      expect(move, 2);
    });

    test('hard mode finds winning move', () {
      final List<Player> board = List<Player>.filled(9, Player.none);
      board[0] = Player.o;
      board[1] = Player.o;
      board[3] = Player.x;
      board[4] = Player.x;
      
      final Game game = Game.initial(const GameSettings()).copyWith(board: board, currentPlayer: Player.o);
      
      final int move = botService.getMove(game, GridSize.normal, BotDifficulty.hard);
      expect(move, 2);
    });
  });
}
