import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/presentation/extensions/player_extension.dart';

class Cell extends ConsumerStatefulWidget {
  const Cell({
    super.key,
    required this.player,
    required this.isWinningCell,
  });

  final Player player;
  final bool isWinningCell;

  @override
  ConsumerState<Cell> createState() => _CellState();
}

class _CellState extends ConsumerState<Cell> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final AnimationController _pressController;
  late final Animation<double> _pressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(
      begin: .0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _pressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _pressAnimation = Tween<double>(
      begin: 8.0,
      end: .0,
    ).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant Cell oldWidget) {
    if (oldWidget.player.isNone && widget.player != Player.none) {
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GridSize gridSize = ref.watch(gameSettingsProvider).gridSize;
    final double iconSize;
    switch (gridSize) {
      case GridSize.normal:
        iconSize = 48.0;
        break;
      case GridSize.large:
        iconSize = 32.0;
        break;
      case GridSize.huge:
        iconSize = 24.0;
        break;
    }
    return GestureDetector(
      onTapDown: (_) {
        _pressController.forward();
      },
      onTapUp: (_) {
        _pressController.reverse();
      },
      onTapCancel: () => _pressController.reverse(),
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (BuildContext context, Widget? child) {
          return Container(
            margin: .only(top: 8.0 - _pressAnimation.value, bottom: _pressAnimation.value),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: widget.player != Player.none
                      ? widget.player.getColor(Theme.of(context))
                      : Theme.of(context).colorScheme.secondary.withValues(alpha: .8),
                  offset: Offset(0, _pressAnimation.value),
                ),
              ],
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: widget.player == Player.none
                    ? null
                    : Icon(
                        widget.player .isX ? Icons.close : Icons.circle_outlined,
                        size: iconSize,
                        color: widget.player.getColor(Theme.of(context))
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
