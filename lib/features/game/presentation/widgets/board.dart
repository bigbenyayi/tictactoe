import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/application/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/presentation/extensions/player_extension.dart';
import 'package:tictactoe/features/game/presentation/widgets/cell.dart';
import 'package:tictactoe/features/game/presentation/widgets/winning_line_painter.dart';

class Board extends ConsumerStatefulWidget {
  const Board({super.key});

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> with TickerProviderStateMixin {
  late final AnimationController _lineController;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Game game = ref.watch(gameProvider);
    final GameSettings gameSettings = ref.watch(gameSettingsProvider);

    ref.listen<Game>(gameProvider, (Game? previous, Game next) {
      final List<int>? prevWinningLine = previous?.winningLine;
      final List<int>? nextWinningLine = next.winningLine;

      if (nextWinningLine != null && prevWinningLine == null) {
        _lineController.forward(from: 0);
      }
      if (nextWinningLine == null && prevWinningLine != null) {
        _lineController.reset();
      }
    });

    const double spacing = 12.0;
    return Padding(
      padding: const .symmetric(horizontal: 8.0),
      child: AnimatedBuilder(
        animation: _lineController,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            foregroundPainter: game.winningLine != null
                ? WinningLinePainter(
                    winningLine: game.winningLine!,
                    progress: _lineController.value,
                    color: game.winner!.getColor(Theme.of(context)),
                    gridSize: gameSettings.gridSize.dimension,
                    spacing: spacing,
                  )
                : null,
            child: child,
          );
        },
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gameSettings.gridSize.dimension,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
          ),
          itemCount: gameSettings.gridSize.dimension * gameSettings.gridSize.dimension,
          itemBuilder: (BuildContext context, int index) {
            final bool isWinningCell = game.winningLine?.contains(index) ?? false;
            return Listener(
              onPointerDown: (_) => ref.read(gameProvider.notifier).makeMove(index),
              child: Cell(
                player: game.board[index],
                isWinningCell: isWinningCell,
              ),
            );
          },
        ),
      ),
    );
  }
}
