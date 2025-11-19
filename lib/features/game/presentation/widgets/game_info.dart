import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe/features/game/application/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/application/notifiers/timer_notifier.dart';
import 'package:tictactoe/features/game/domain/entities/game.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';
import 'package:tictactoe/features/game/presentation/extensions/player_extension.dart';
import 'package:tictactoe/l10n/l10n.dart';

class GameInfo extends ConsumerWidget {
  const GameInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyle = theme.textTheme.headlineMedium!;
    final Color primaryColor = theme.colorScheme.primary;

    final Game game = ref.watch(gameProvider);
    final GameSettings settings = ref.watch(gameSettingsProvider);
    final int? timer = ref.watch(timerProvider);

    final String timerValue = ((timer ?? 0) / 1000).toStringAsFixed(2);

    final bool isBot = settings.opponent.isBot;

    return Stack(
      alignment: .center,
      children: <Widget>[
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: game.winner == null ? 1.0 : 0.0,
          child: IgnorePointer(
            ignoring: game.winner != null,
            child: Column(
              mainAxisAlignment: .center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: .spaceEvenly,
                  children: <Widget>[
                    _PlayerInfoHeader(
                      icon: FontAwesomeIcons.xmark,
                      label: isBot ? l10n.you : '${l10n.player} 1',
                      iconColor: primaryColor,
                      labelColor: primaryColor,
                      isCurrentPlayer: game.currentPlayer.isX && game.winner == null,
                    ),
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.headlineMedium,
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'V',
                            style: textStyle.copyWith(color: primaryColor),
                          ),
                          TextSpan(
                            text: 'S',
                            style: textStyle.copyWith(color: theme.colorScheme.tertiary),
                          ),
                        ],
                      ),
                    ),
                    _PlayerInfoHeader(
                      icon: FontAwesomeIcons.circle,
                      label: isBot ? l10n.bot : '${l10n.player} 2',
                      iconColor: theme.colorScheme.tertiary,
                      labelColor: theme.colorScheme.tertiary,
                      isCurrentPlayer: game.currentPlayer.isO && game.winner == null,
                    ),
                  ],
                ),
                if (settings.gameMode.isBlitz) ...<Widget>[
                  const SizedBox(height: 20),
                  Text(
                    '${timerValue}s',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: game.currentPlayer.getColor(theme),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: game.winner != null ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            game.winner == Player.none ? l10n.draw : l10n.playerWins(game.winner?.displayName ?? ''),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: game.winner == Player.x ? primaryColor : theme.colorScheme.tertiary,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayerInfoHeader extends StatelessWidget {
  const _PlayerInfoHeader({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.labelColor,
    required this.isCurrentPlayer,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final Color labelColor;
  final bool isCurrentPlayer;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Column content = Column(
      children: <Widget>[
        FaIcon(icon, color: iconColor, size: 40),
        const SizedBox(height: 8),
        Text(
          label,
          style: isCurrentPlayer
              ? textTheme.titleLarge?.copyWith(color: labelColor)
              : textTheme.titleMedium?.copyWith(color: labelColor),
        ),
      ],
    );

    return AnimatedScale(
      scale: isCurrentPlayer ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: content,
    );
  }
}
