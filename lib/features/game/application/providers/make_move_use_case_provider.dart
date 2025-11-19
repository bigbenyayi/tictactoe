import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/application/providers/winner_checker_provider.dart';
import 'package:tictactoe/features/game/domain/use_cases/make_move_use_case.dart';

part 'make_move_use_case_provider.g.dart';

@riverpod
MakeMoveUseCase makeMoveUseCase(Ref ref) {
  return MakeMoveUseCase(ref.watch(winnerCheckerServiceProvider));
}
