import 'package:tictactoe/features/game/domain/enums/grid_size.dart';

extension GridSizeExtension on GridSize {
  String get sizeLabel => '${dimension}x$dimension';
}