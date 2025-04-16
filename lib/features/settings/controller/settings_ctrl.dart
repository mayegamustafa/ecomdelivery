import 'dart:async';

import 'package:delivery_boy/features/settings/repository/settings_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_ctrl.g.dart';

@riverpod
class AppSettingsCtrl extends _$AppSettingsCtrl {
  final _repo = locate<SettingsRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<AppSettings> _init() async {
    final settings = await _repo.getApiSettings();
    return settings.fold(
      (l) => l.toFError(),
      (r) {
        ref.read(localSettingsCtrlProvider.notifier).save(r.data);
        return r.data;
      },
    );
  }

  @override
  FutureOr<AppSettings> build() async {
    return await _init();
  }
}

@Riverpod(keepAlive: true)
class LocalSettingsCtrl extends _$LocalSettingsCtrl {
  @override
  AppSettings? build() {
    return locate<SettingsRepo>().getAppSettingsSync();
  }

  Future<void> save(AppSettings settings) async {
    await locate<SettingsRepo>().saveSettings(settings);
    ref.invalidateSelf();
  }
}
