// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderListCtrlHash() => r'4fbf6316f4235c1020c49749eb6df4563b6ef744';

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

abstract class _$OrderListCtrl
    extends BuildlessAutoDisposeAsyncNotifier<PagedItem<ProductOrder>> {
  late final String? status;

  FutureOr<PagedItem<ProductOrder>> build(
    String? status,
  );
}

/// See also [OrderListCtrl].
@ProviderFor(OrderListCtrl)
const orderListCtrlProvider = OrderListCtrlFamily();

/// See also [OrderListCtrl].
class OrderListCtrlFamily extends Family<AsyncValue<PagedItem<ProductOrder>>> {
  /// See also [OrderListCtrl].
  const OrderListCtrlFamily();

  /// See also [OrderListCtrl].
  OrderListCtrlProvider call(
    String? status,
  ) {
    return OrderListCtrlProvider(
      status,
    );
  }

  @override
  OrderListCtrlProvider getProviderOverride(
    covariant OrderListCtrlProvider provider,
  ) {
    return call(
      provider.status,
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
  String? get name => r'orderListCtrlProvider';
}

/// See also [OrderListCtrl].
class OrderListCtrlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OrderListCtrl, PagedItem<ProductOrder>> {
  /// See also [OrderListCtrl].
  OrderListCtrlProvider(
    String? status,
  ) : this._internal(
          () => OrderListCtrl()..status = status,
          from: orderListCtrlProvider,
          name: r'orderListCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderListCtrlHash,
          dependencies: OrderListCtrlFamily._dependencies,
          allTransitiveDependencies:
              OrderListCtrlFamily._allTransitiveDependencies,
          status: status,
        );

  OrderListCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  FutureOr<PagedItem<ProductOrder>> runNotifierBuild(
    covariant OrderListCtrl notifier,
  ) {
    return notifier.build(
      status,
    );
  }

  @override
  Override overrideWith(OrderListCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderListCtrlProvider._internal(
        () => create()..status = status,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OrderListCtrl,
      PagedItem<ProductOrder>> createElement() {
    return _OrderListCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderListCtrlProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderListCtrlRef
    on AutoDisposeAsyncNotifierProviderRef<PagedItem<ProductOrder>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _OrderListCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OrderListCtrl,
        PagedItem<ProductOrder>> with OrderListCtrlRef {
  _OrderListCtrlProviderElement(super.provider);

  @override
  String? get status => (origin as OrderListCtrlProvider).status;
}

String _$orderCtrlHash() => r'5ccbdecf7182dc4c40e18b6e59313908dc864c70';

abstract class _$OrderCtrl
    extends BuildlessAutoDisposeAsyncNotifier<ProductOrder> {
  late final String orderId;

  FutureOr<ProductOrder> build(
    String orderId,
  );
}

/// See also [OrderCtrl].
@ProviderFor(OrderCtrl)
const orderCtrlProvider = OrderCtrlFamily();

/// See also [OrderCtrl].
class OrderCtrlFamily extends Family<AsyncValue<ProductOrder>> {
  /// See also [OrderCtrl].
  const OrderCtrlFamily();

  /// See also [OrderCtrl].
  OrderCtrlProvider call(
    String orderId,
  ) {
    return OrderCtrlProvider(
      orderId,
    );
  }

  @override
  OrderCtrlProvider getProviderOverride(
    covariant OrderCtrlProvider provider,
  ) {
    return call(
      provider.orderId,
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
  String? get name => r'orderCtrlProvider';
}

/// See also [OrderCtrl].
class OrderCtrlProvider
    extends AutoDisposeAsyncNotifierProviderImpl<OrderCtrl, ProductOrder> {
  /// See also [OrderCtrl].
  OrderCtrlProvider(
    String orderId,
  ) : this._internal(
          () => OrderCtrl()..orderId = orderId,
          from: orderCtrlProvider,
          name: r'orderCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderCtrlHash,
          dependencies: OrderCtrlFamily._dependencies,
          allTransitiveDependencies: OrderCtrlFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  OrderCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  FutureOr<ProductOrder> runNotifierBuild(
    covariant OrderCtrl notifier,
  ) {
    return notifier.build(
      orderId,
    );
  }

  @override
  Override overrideWith(OrderCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderCtrlProvider._internal(
        () => create()..orderId = orderId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OrderCtrl, ProductOrder>
      createElement() {
    return _OrderCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderCtrlProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderCtrlRef on AutoDisposeAsyncNotifierProviderRef<ProductOrder> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OrderCtrl, ProductOrder>
    with OrderCtrlRef {
  _OrderCtrlProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderCtrlProvider).orderId;
}

String _$deliveryManCtrlHash() => r'74c6ba517677bbd83f561f74869f821fdfed2c7e';

/// See also [DeliveryManCtrl].
@ProviderFor(DeliveryManCtrl)
final deliveryManCtrlProvider = AutoDisposeAsyncNotifierProvider<
    DeliveryManCtrl, List<DeliveryMan>>.internal(
  DeliveryManCtrl.new,
  name: r'deliveryManCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deliveryManCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeliveryManCtrl = AutoDisposeAsyncNotifier<List<DeliveryMan>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
