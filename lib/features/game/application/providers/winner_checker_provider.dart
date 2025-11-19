import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/services/winner_checker_service.dart';

part 'winner_checker_provider.g.dart';

@riverpod
WinnerCheckerService winnerCheckerService(Ref ref) {
  return WinnerCheckerService();
}
