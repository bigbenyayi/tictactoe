import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme_data.freezed.dart';

@freezed
abstract class AppThemeColorData with _$AppThemeColorData {
  const factory AppThemeColorData({
    required Color primary,
    required Color secondary,
    required Color tertiary,
    required Color background,
    required Color neutral,
  }) = _AppThemeColorData;

  factory AppThemeColorData.light() => const AppThemeColorData(
    primary: Color(0xFF473573),
    secondary: Color(0xFF52639E),
    tertiary: Color(0xFFD7F5ED),
    background: Color(0xFF87BAC3),
    neutral: Color(0xFF333333),
  );

  factory AppThemeColorData.dark() => const AppThemeColorData(
    primary: Color(0xFFBB86FC),
    secondary: Color(0xFFBB86FC),
    tertiary: Color(0xFFBB86FC),
    background: Color(0xFF121212),
    neutral: Color(0xFFB4B4B4),
  );
}
