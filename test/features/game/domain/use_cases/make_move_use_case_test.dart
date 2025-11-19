import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/domain/services/winner_checker_service.dart';
import 'package:tictactoe/features/game/domain/use_cases/make_move_use_case.dart';

class MockWinnerCheckerService extends Mock implements WinnerCheckerService {}

void main() {
  late MakeMoveUseCase useCase;
  late MockWinnerCheckerService mockWinnerCheckerService;

  setUp(() {
    mockWinnerCheckerService = MockWinnerCheckerService();
    useCase = MakeMoveUseCase(mockWinnerCheckerService);
  });

  setUpAll(() {
    registerFallbackValue(GridSize.normal);
    registerFallbackValue(<Player>[]);
  });

  group('MakeMoveUseCase (unit test)', () {
    test('places a move and switches player', () {
      final Game game = Game.initial(const GameSettings());

      when(() => mockWinnerCheckerService.checkWinner(any(), any())).thenReturn(null);

      final Game newGame = useCase(game, 0, GridSize.normal);

      expect(newGame.board[0], Player.x);
      expect(newGame.currentPlayer, Player.o);
      expect(newGame.winner, null);

      verify(() => mockWinnerCheckerService.checkWinner(newGame.board, GridSize.normal)).called(1);
    });

    test('returns same game if move is invalid (occupied cell)', () {
      Game game = Game.initial(const GameSettings());
      game = useCase(game, 0, GridSize.normal);

      final Game result = useCase(game, 0, GridSize.normal);

      expect(result.board[0], Player.x);
      expect(result.currentPlayer, Player.o);
      expect(result.winner, isNull);
      expect(result, same(game));
    });

    test('returns same game if game already has a winner', () {
      final Game game = Game.initial(const GameSettings()).copyWith(winner: Player.x);

      final Game result = useCase(game, 0, GridSize.normal);

      expect(result, same(game));
      verifyNever(() => mockWinnerCheckerService.checkWinner(any(), any()));
    });

    test('sets winner and winning line when service returns winner', () {
      final Game game = Game.initial(const GameSettings());

      when(() => mockWinnerCheckerService.checkWinner(any(), any())).thenReturn(<int>[0, 1, 2]);

      final Game newGame = useCase(game, 0, GridSize.normal);

      expect(newGame.winner, Player.x);
      expect(newGame.winningLine, <int>[0, 1, 2]);

      verify(() => mockWinnerCheckerService.checkWinner(any(), any())).called(1);
    });

    test('detects draw when no empty cells remain', () {
      final List<Player> board = <Player>[
        Player.x, Player.o, Player.x,
        Player.x, Player.o, Player.o,
        Player.o, Player.x, Player.none,
      ];

      final Game game = Game.initial(const GameSettings()).copyWith(board: board, currentPlayer: Player.x);

      when(() => mockWinnerCheckerService.checkWinner(any(), any())).thenReturn(null);

      final Game newGame = useCase(game, 8, GridSize.normal);

      expect(newGame.winner, Player.none);
      expect(newGame.board[8], Player.x);
      verify(() => mockWinnerCheckerService.checkWinner(any(), any())).called(1);
    });
  });
}
