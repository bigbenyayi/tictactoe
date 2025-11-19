import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/application/notifiers/game_settings_notifier.dart';
import 'package:tictactoe/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe/features/game/domain/enums/bot_difficulty.dart';
import 'package:tictactoe/features/game/domain/enums/game_mode.dart';
import 'package:tictactoe/features/game/domain/enums/grid_size.dart';
import 'package:tictactoe/features/game/domain/enums/opponent.dart';
import 'package:tictactoe/features/game/presentation/extensions/bot_difficulty_extension.dart';
import 'package:tictactoe/features/game/presentation/extensions/game_mode_extension.dart';
import 'package:tictactoe/features/game/presentation/extensions/grid_size_extension.dart';
import 'package:tictactoe/features/game/presentation/extensions/opponent_extension.dart';
import 'package:tictactoe/features/game/presentation/widgets/titled_segmented_button.dart';
import 'package:tictactoe/l10n/l10n.dart';
import 'package:tictactoe/routing/app_router.dart';

part '../widgets/game_settings_segmented_buttons.dart';
part '../widgets/grid_size_carousel.dart';
part '../widgets/start_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .stretch,
          children: <Widget>[
            Expanded(child: _GridSizeCarousel()),
            Column(
              crossAxisAlignment: .stretch,
              children: <Widget>[
                _GameSettingsSegmentedButtons(),
                SizedBox(height: 32.0),
                _StartButton(),
                SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
