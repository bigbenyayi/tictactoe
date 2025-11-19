import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe/features/game/domain/enums/opponent.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

extension OpponentExtension on Opponent {
  String getLabel(AppLocalizations l10n) {
    switch (this) {
      case .friend:
        return l10n.friend;
      case .bot:
        return l10n.bot;
    }
  }

  IconData get icon {
    switch (this) {
      case .friend:
        return FontAwesomeIcons.solidUser;
      case .bot:
        return FontAwesomeIcons.robot;
    }
  }
}
