// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_massage_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketMessageCtrlHash() => r'a07c5e5b3f8e52ccddfdad729b2774b44f1949f6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TicketMessageCtrl
    extends BuildlessAutoDisposeAsyncNotifier<TicketData> {
  late final String arg;

  FutureOr<TicketData> build(
    String arg,
  );
}

/// See also [TicketMessageCtrl].
@ProviderFor(TicketMessageCtrl)
const ticketMessageCtrlProvider = TicketMessageCtrlFamily();

/// See also [TicketMessageCtrl].
class TicketMessageCtrlFamily extends Family<AsyncValue<TicketData>> {
  /// See also [TicketMessageCtrl].
  const TicketMessageCtrlFamily();

  /// See also [TicketMessageCtrl].
  TicketMessageCtrlProvider call(
    String arg,
  ) {
    return TicketMessageCtrlProvider(
      arg,
    );
  }

  @override
  TicketMessageCtrlProvider getProviderOverride(
    covariant TicketMessageCtrlProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ticketMessageCtrlProvider';
}

/// See also [TicketMessageCtrl].
class TicketMessageCtrlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TicketMessageCtrl, TicketData> {
  /// See also [TicketMessageCtrl].
  TicketMessageCtrlProvider(
    String arg,
  ) : this._internal(
          () => TicketMessageCtrl()..arg = arg,
          from: ticketMessageCtrlProvider,
          name: r'ticketMessageCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ticketMessageCtrlHash,
          dependencies: TicketMessageCtrlFamily._dependencies,
          allTransitiveDependencies:
              TicketMessageCtrlFamily._allTransitiveDependencies,
          arg: arg,
        );

  TicketMessageCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final String arg;

  @override
  FutureOr<TicketData> runNotifierBuild(
    covariant TicketMessageCtrl notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(TicketMessageCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: TicketMessageCtrlProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TicketMessageCtrl, TicketData>
      createElement() {
    return _TicketMessageCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketMessageCtrlProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TicketMessageCtrlRef on AutoDisposeAsyncNotifierProviderRef<TicketData> {
  /// The parameter `arg` of this provider.
  String get arg;
}

class _TicketMessageCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TicketMessageCtrl,
        TicketData> with TicketMessageCtrlRef {
  _TicketMessageCtrlProviderElement(super.provider);

  @override
  String get arg => (origin as TicketMessageCtrlProvider).arg;
}

String _$ticketCreateCtrlHash() => r'fd2a0e171950f997a8b84ede8dbacbbf04810a59';

/// See also [TicketCreateCtrl].
@ProviderFor(TicketCreateCtrl)
final ticketCreateCtrlProvider =
    AutoDisposeNotifierProvider<TicketCreateCtrl, TicketCreateState>.internal(
  TicketCreateCtrl.new,
  name: r'ticketCreateCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ticketCreateCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TicketCreateCtrl = AutoDisposeNotifier<TicketCreateState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
