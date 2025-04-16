import 'package:flutter/material.dart';

class IGenColorScheme {
  const IGenColorScheme._();

  static ColorScheme scheme(bool isLight) {
    return ColorScheme(
      brightness: isLight ? Brightness.light : Brightness.dark,
      primary: const Color(0xffED4650),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer:
          isLight ? const Color(0xF5FFFFFF) : const Color(0xFF333645),
      onPrimaryContainer:
          isLight ? const Color(0xF5F7F7F7) : const Color(0xff232531),
      secondary: const Color(0xFFFFFFFF),
      onSecondary: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
      secondaryContainer: const Color(0xff00EB8B),
      onSecondaryContainer: const Color(0xFF111F11),
      tertiary: const Color(0xfffea34c),
      onTertiary: const Color.fromARGB(255, 41, 39, 39),
      tertiaryContainer:
          isLight ? const Color(0xff94b291) : const Color(0xff394337),
      onTertiaryContainer:
          isLight ? const Color(0xff0d0f0c) : const Color(0xFFF8FFF8),
      error: isLight ? const Color(0xffb00020) : const Color(0xFFE74C4C),
      onError: const Color(0xFFFFF9F9),
      errorContainer: const Color(0xFF009721),
      onErrorContainer: const Color(0xFFF8FFF9),
      surface: isLight ? const Color(0xFFFFFFFF) : const Color(0xFF282A36),
      onSurface: isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
      surfaceContainerHighest: const Color(0xFF000000),
      onSurfaceVariant:
          isLight ? const Color(0xFF262626) : const Color(0xFFE0E0E0),
      surfaceBright:
          isLight ? const Color(0xff0C0C0C) : const Color(0xffffffff),
      outline: isLight ? const Color(0xFFC1C1C1) : const Color(0xFF6B6C6B),
      outlineVariant:
          isLight ? const Color(0xFF6B6C6B) : const Color(0xFFC1C1C1),
      shadow: isLight ? const Color(0xFFF0F0F0) : const Color(0xFF20222B),
      scrim: const Color(0xffe84c1b),
      inverseSurface:
          isLight ? const Color(0xFF142714) : const Color(0xFFE8EAE8),
      onInverseSurface:
          isLight ? const Color(0xFFE8EAE8) : const Color(0xFF142714),
      inversePrimary: const Color(0xff2E5434),
      surfaceTint: isLight ? const Color(0xffffffff) : const Color(0xFF333645),
    );
  }
}
