// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_chat_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerChatCtrlHash() => r'0b17d27ee48222be0807b5444b364f0dff16b7bb';

/// See also [CustomerChatCtrl].
@ProviderFor(CustomerChatCtrl)
final customerChatCtrlProvider = AutoDisposeAsyncNotifierProvider<
    CustomerChatCtrl, List<CustomerData>>.internal(
  CustomerChatCtrl.new,
  name: r'customerChatCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customerChatCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomerChatCtrl = AutoDisposeAsyncNotifier<List<CustomerData>>;
String _$customerMessageCtrlHash() =>
    r'dc6417fa328432130c04cf3b5c48c359a100f05f';

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

abstract class _$CustomerMessageCtrl
    extends BuildlessAutoDisposeAsyncNotifier<CustomerChat> {
  late final String id;

  FutureOr<CustomerChat> build(
    String id,
  );
}

/// See also [CustomerMessageCtrl].
@ProviderFor(CustomerMessageCtrl)
const customerMessageCtrlProvider = CustomerMessageCtrlFamily();

/// See also [CustomerMessageCtrl].
class CustomerMessageCtrlFamily extends Family<AsyncValue<CustomerChat>> {
  /// See also [CustomerMessageCtrl].
  const CustomerMessageCtrlFamily();

  /// See also [CustomerMessageCtrl].
  CustomerMessageCtrlProvider call(
    String id,
  ) {
    return CustomerMessageCtrlProvider(
      id,
    );
  }

  @override
  CustomerMessageCtrlProvider getProviderOverride(
    covariant CustomerMessageCtrlProvider provider,
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
  String? get name => r'customerMessageCtrlProvider';
}

/// See also [CustomerMessageCtrl].
class CustomerMessageCtrlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CustomerMessageCtrl, CustomerChat> {
  /// See also [CustomerMessageCtrl].
  CustomerMessageCtrlProvider(
    String id,
  ) : this._internal(
          () => CustomerMessageCtrl()..id = id,
          from: customerMessageCtrlProvider,
          name: r'customerMessageCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerMessageCtrlHash,
          dependencies: CustomerMessageCtrlFamily._dependencies,
          allTransitiveDependencies:
              CustomerMessageCtrlFamily._allTransitiveDependencies,
          id: id,
        );

  CustomerMessageCtrlProvider._internal(
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
  FutureOr<CustomerChat> runNotifierBuild(
    covariant CustomerMessageCtrl notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(CustomerMessageCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerMessageCtrlProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CustomerMessageCtrl, CustomerChat>
      createElement() {
    return _CustomerMessageCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerMessageCtrlProvider && other.id == id;
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
mixin CustomerMessageCtrlRef
    on AutoDisposeAsyncNotifierProviderRef<CustomerChat> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CustomerMessageCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CustomerMessageCtrl,
        CustomerChat> with CustomerMessageCtrlRef {
  _CustomerMessageCtrlProviderElement(super.provider);

  @override
  String get id => (origin as CustomerMessageCtrlProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
