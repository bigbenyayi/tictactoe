import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/theme/app_theme_data.dart';
import 'package:tictactoe/l10n/app_localizations.dart';
import 'package:tictactoe/routing/app_router.dart';

final GoRouter _router = GoRouter(routes: $appRoutes);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,

          primary: AppThemeColorData.light().primary,
          onPrimary: Colors.white,

          secondary: AppThemeColorData.light().secondary,
          onSecondary: Colors.white,

          tertiary: AppThemeColorData.light().tertiary,

          surface: Colors.white,
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
        textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Audiowide'),
        scaffoldBackgroundColor: AppThemeColorData.light().background,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: FadeForwardsPageTransitionsBuilder(
              backgroundColor: AppThemeColorData.light().background,
            ),
            TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(
              backgroundColor: AppThemeColorData.light().background,
            ),
          },
        ),
        toggleButtonsTheme: ToggleButtonsThemeData(
          color: AppThemeColorData.light().neutral,
          selectedColor: Colors.white,
          fillColor: AppThemeColorData.light().secondary,
        )
      ),
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
