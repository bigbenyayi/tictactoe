import 'package:flutter/material.dart';
import 'package:tictactoe/features/game/domain/enums/player.dart';

extension PlayerExtension on Player {
  String get displayName {
    switch (this) {
      case .x:
        return 'X';
      case .o:
        return 'O';
      case .none:
        return '';
    }
  }

  Color getColor(ThemeData themeData) {
    switch (this) {
      case Player.x:
        return themeData.primaryColor;
      case Player.o:
        return themeData.colorScheme.tertiary;
      case Player.none:
        return Colors.transparent;
    }
  }
}