// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appSettingsCtrlHash() => r'38c828731b75718b450ab66423ec7e0acf135d96';

/// See also [AppSettingsCtrl].
@ProviderFor(AppSettingsCtrl)
final appSettingsCtrlProvider =
    AutoDisposeAsyncNotifierProvider<AppSettingsCtrl, AppSettings>.internal(
  AppSettingsCtrl.new,
  name: r'appSettingsCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appSettingsCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppSettingsCtrl = AutoDisposeAsyncNotifier<AppSettings>;
String _$localSettingsCtrlHash() => r'7a057933ac96ef83f3652361e191838e73adea7b';

/// See also [LocalSettingsCtrl].
@ProviderFor(LocalSettingsCtrl)
final localSettingsCtrlProvider =
    NotifierProvider<LocalSettingsCtrl, AppSettings?>.internal(
  LocalSettingsCtrl.new,
  name: r'localSettingsCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localSettingsCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocalSettingsCtrl = Notifier<AppSettings?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
