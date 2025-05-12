// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveryman_chat_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deliveryManChatCtrlHash() =>
    r'59f499feb829de64e67b615c25dc15947ca7783c';

/// See also [DeliveryManChatCtrl].
@ProviderFor(DeliveryManChatCtrl)
final deliveryManChatCtrlProvider = AutoDisposeAsyncNotifierProvider<
    DeliveryManChatCtrl, List<DeliveryMan>>.internal(
  DeliveryManChatCtrl.new,
  name: r'deliveryManChatCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deliveryManChatCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeliveryManChatCtrl = AutoDisposeAsyncNotifier<List<DeliveryMan>>;
String _$deliveryManChatMessageCtrlHash() =>
    r'4efe67449ed0717b70171214629827db1ecfe5c2';

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

abstract class _$DeliveryManChatMessageCtrl
    extends BuildlessAutoDisposeAsyncNotifier<DeliveryManChat> {
  late final String id;

  FutureOr<DeliveryManChat> build(
    String id,
  );
}

/// See also [DeliveryManChatMessageCtrl].
@ProviderFor(DeliveryManChatMessageCtrl)
const deliveryManChatMessageCtrlProvider = DeliveryManChatMessageCtrlFamily();

/// See also [DeliveryManChatMessageCtrl].
class DeliveryManChatMessageCtrlFamily
    extends Family<AsyncValue<DeliveryManChat>> {
  /// See also [DeliveryManChatMessageCtrl].
  const DeliveryManChatMessageCtrlFamily();

  /// See also [DeliveryManChatMessageCtrl].
  DeliveryManChatMessageCtrlProvider call(
    String id,
  ) {
    return DeliveryManChatMessageCtrlProvider(
      id,
    );
  }

  @override
  DeliveryManChatMessageCtrlProvider getProviderOverride(
    covariant DeliveryManChatMessageCtrlProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'deliveryManChatMessageCtrlProvider';
}

/// See also [DeliveryManChatMessageCtrl].
class DeliveryManChatMessageCtrlProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DeliveryManChatMessageCtrl,
        DeliveryManChat> {
  /// See also [DeliveryManChatMessageCtrl].
  DeliveryManChatMessageCtrlProvider(
    String id,
  ) : this._internal(
          () => DeliveryManChatMessageCtrl()..id = id,
          from: deliveryManChatMessageCtrlProvider,
          name: r'deliveryManChatMessageCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deliveryManChatMessageCtrlHash,
          dependencies: DeliveryManChatMessageCtrlFamily._dependencies,
          allTransitiveDependencies:
              DeliveryManChatMessageCtrlFamily._allTransitiveDependencies,
          id: id,
        );

  DeliveryManChatMessageCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<DeliveryManChat> runNotifierBuild(
    covariant DeliveryManChatMessageCtrl notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(DeliveryManChatMessageCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeliveryManChatMessageCtrlProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DeliveryManChatMessageCtrl,
      DeliveryManChat> createElement() {
    return _DeliveryManChatMessageCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryManChatMessageCtrlProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeliveryManChatMessageCtrlRef
    on AutoDisposeAsyncNotifierProviderRef<DeliveryManChat> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DeliveryManChatMessageCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DeliveryManChatMessageCtrl,
        DeliveryManChat> with DeliveryManChatMessageCtrlRef {
  _DeliveryManChatMessageCtrlProviderElement(super.provider);

  @override
  String get id => (origin as DeliveryManChatMessageCtrlProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
