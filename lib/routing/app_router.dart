import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/features/game/presentation/screens/game_screen.dart';
import 'package:tictactoe/features/game/presentation/screens/home_screen.dart';

part 'app_router.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<GameRoute>(path: '/game')
class GameRoute extends GoRouteData with $GameRoute {
  const GameRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GameScreen();
  }
}
