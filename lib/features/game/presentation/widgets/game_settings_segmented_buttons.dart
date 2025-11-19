part of '../screens/home_screen.dart';

class _GameSettingsSegmentedButtons extends ConsumerWidget {
  const _GameSettingsSegmentedButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = context.l10n;
    final GameSettings settings = ref.watch(gameSettingsProvider);
    final GameSettingsNotifier gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: .stretch,
      spacing: 16.0,
      children: <Widget>[
        TitledSegmentedButton<Opponent>(
            title: l10n.opponent,
            onSelectionChanged: gameSettingsNotifier.setOpponent,
            selected: settings.opponent,
            segments: Opponent.values.map((Opponent o) {
              return SegmentData<Opponent>(value: o, label: o.getLabel(l10n), icon: o.icon);
            }).toList(),
        ),
        TitledSegmentedButton<GameMode>(
            title: l10n.mode,
            onSelectionChanged: gameSettingsNotifier.setGameMode,
            selected: settings.gameMode,
            segments: GameMode.values.map((GameMode gm) {
              return SegmentData<GameMode>(value: gm, label: gm.getLabel(l10n), icon: gm.icon);
            }).toList(),
        ),
        AnimatedOpacity(
          opacity: settings.opponent.isBot ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: TitledSegmentedButton<BotDifficulty>(
              title: l10n.difficulty,
              onSelectionChanged: gameSettingsNotifier.setBotDifficulty,
              selected: settings.botDifficulty,
              segments: BotDifficulty.values.map((BotDifficulty bd) {
                return SegmentData<BotDifficulty>(value: bd, label: bd.getLabel(l10n), icon: bd.icon);
              }).toList(),
          ),
        ),
      ],
    );
  }
}