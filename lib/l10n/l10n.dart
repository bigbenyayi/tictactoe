import 'package:flutter/widgets.dart';
import 'package:tictactoe/l10n/app_localizations.dart';

export 'package:tictactoe/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}