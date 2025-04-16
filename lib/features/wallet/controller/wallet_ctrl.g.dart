// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$withdrawMethodsHash() => r'4c264d1979a927d6b57666fecd6c48ac80679fdc';

/// See also [withdrawMethods].
@ProviderFor(withdrawMethods)
final withdrawMethodsProvider =
    AutoDisposeFutureProvider<List<WithdrawMethod>>.internal(
  withdrawMethods,
  name: r'withdrawMethodsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$withdrawMethodsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WithdrawMethodsRef = AutoDisposeFutureProviderRef<List<WithdrawMethod>>;
String _$withDrawListCtrlHash() => r'0669d5ddb6d13d1eb3c8287715a99ed74f9c3969';

/// See also [WithDrawListCtrl].
@ProviderFor(WithDrawListCtrl)
final withDrawListCtrlProvider = AutoDisposeAsyncNotifierProvider<
    WithDrawListCtrl, PagedItem<WithdrawData>>.internal(
  WithDrawListCtrl.new,
  name: r'withDrawListCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$withDrawListCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WithDrawListCtrl = AutoDisposeAsyncNotifier<PagedItem<WithdrawData>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
