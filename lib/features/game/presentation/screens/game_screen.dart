import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe/features/game/application/notifiers/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/widgets/board.dart';
import 'package:tictactoe/features/game/presentation/widgets/game_info.dart';
import 'package:tictactoe/l10n/l10n.dart';
import 'package:tictactoe/routing/app_router.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .spaceAround,
          children: <Widget>[
            const Spacer(),
            const GameInfo(),
            const SizedBox(height: 16.0),
            const Spacer(),
            const Board(),
            const Spacer(),
            Row(
              mainAxisAlignment: .center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: .circular(15.0)),
                    ),
                    backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    const HomeRoute().go(context);
                  },
                  child: Padding(
                    padding: const .all(8.0),
                    child: Row(
                      spacing: 8.0,
                      children: <Widget>[
                        const Icon(
                          FontAwesomeIcons.solidHouse,
                          color: Colors.white,
                        ),
                        Text(
                          l10n.home,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: .circular(15.0)),
                    ),
                    backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
                  ),
                  onPressed: () => ref.read(gameProvider.notifier).resetGame(),
                  child: Padding(
                    padding: const .all(8.0),
                    child: Row(
                      spacing: 8.0,
                      children: <Widget>[
                        const Icon(
                          FontAwesomeIcons.rotateRight,
                          color: Colors.white,
                        ),
                        Text(
                          l10n.reset,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
