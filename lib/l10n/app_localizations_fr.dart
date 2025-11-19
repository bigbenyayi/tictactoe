// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Moyen';

  @override
  String get hard => 'Difficile';

  @override
  String get start => 'Commencer';

  @override
  String get draw => 'Égalité !';

  @override
  String playerWins(Object player) {
    return 'Le joueur $player gagne !';
  }

  @override
  String connectNToWin(Object n) {
    return 'Connectez-en $n pour gagner';
  }

  @override
  String get difficulty => 'Difficulté';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get home => 'Menu';

  @override
  String get opponent => 'Adversaire';

  @override
  String get player => 'Joueur';

  @override
  String get bot => 'Bot';

  @override
  String get mode => 'Mode';

  @override
  String get normalMode => 'Normal';

  @override
  String get blitz => 'Blitz';

  @override
  String get you => 'Toi';

  @override
  String get friend => 'Ami';
}
