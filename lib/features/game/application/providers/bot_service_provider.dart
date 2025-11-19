import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/application/providers/winner_checker_provider.dart';
import 'package:tictactoe/features/game/application/services/bot_service.dart';

part 'bot_service_provider.g.dart';

@riverpod
BotService botService(Ref ref) {
  return BotService(ref.watch(winnerCheckerServiceProvider));
}
