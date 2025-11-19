// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get start => 'Start';

  @override
  String get draw => 'It\'s a draw!';

  @override
  String playerWins(Object player) {
    return 'Player $player wins!';
  }

  @override
  String connectNToWin(Object n) {
    return 'Connect $n to win';
  }

  @override
  String get difficulty => 'Difficulty';

  @override
  String get reset => 'Reset';

  @override
  String get home => 'Home';

  @override
  String get opponent => 'Opponent';

  @override
  String get player => 'Player';

  @override
  String get bot => 'Bot';

  @override
  String get mode => 'Mode';

  @override
  String get normalMode => 'Normal';

  @override
  String get blitz => 'Blitz';

  @override
  String get you => 'You';

  @override
  String get friend => 'Friend';
}
