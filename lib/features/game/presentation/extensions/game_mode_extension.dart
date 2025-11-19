import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe/features/game/domain/enums/game_mode.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

extension GameModeExtension on GameMode {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case .normal:
        return l10n.normalMode;
      case .blitz:
        return l10n.blitz;
    }
  }

  IconData get icon {
    switch (this) {
      case GameMode.normal:
        return FontAwesomeIcons.check;
      case GameMode.blitz:
        return FontAwesomeIcons.boltLightning;
    }
  }
}
