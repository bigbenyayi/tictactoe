import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

extension BotDifficultyExtension on BotDifficulty {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case .easy:
        return l10n.easy;
      case .medium:
        return l10n.medium;
      case .hard:
        return l10n.hard;
    }
  }

  IconData get icon {
    switch (this) {
      case .easy:
        return FontAwesomeIcons.seedling;
      case .medium:
        return FontAwesomeIcons.fire;
      case .hard:
        return FontAwesomeIcons.skull;
    }
  }
}
