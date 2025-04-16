// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_order_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestOrderCtrlHash() => r'b80f428b9f9657eb43193d5b20e885241148d0f9';

/// See also [RequestOrderCtrl].
@ProviderFor(RequestOrderCtrl)
final requestOrderCtrlProvider = AutoDisposeAsyncNotifierProvider<
    RequestOrderCtrl, PagedItem<ProductOrder>>.internal(
  RequestOrderCtrl.new,
  name: r'requestOrderCtrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$requestOrderCtrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RequestOrderCtrl = AutoDisposeAsyncNotifier<PagedItem<ProductOrder>>;
String _$assignOrderCtrlHash() => r'e42e74034a04c1a026acb55a7f42160e18eddcc4';

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

abstract class _$AssignOrderCtrl
    extends BuildlessAutoDisposeAsyncNotifier<PagedItem<AssignedOrder>> {
  late final String type;

  FutureOr<PagedItem<AssignedOrder>> build(
    String type,
  );
}

/// See also [AssignOrderCtrl].
@ProviderFor(AssignOrderCtrl)
const assignOrderCtrlProvider = AssignOrderCtrlFamily();

/// See also [AssignOrderCtrl].
class AssignOrderCtrlFamily
    extends Family<AsyncValue<PagedItem<AssignedOrder>>> {
  /// See also [AssignOrderCtrl].
  const AssignOrderCtrlFamily();

  /// See also [AssignOrderCtrl].
  AssignOrderCtrlProvider call(
    String type,
  ) {
    return AssignOrderCtrlProvider(
      type,
    );
  }

  @override
  AssignOrderCtrlProvider getProviderOverride(
    covariant AssignOrderCtrlProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'assignOrderCtrlProvider';
}

/// See also [AssignOrderCtrl].
class AssignOrderCtrlProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AssignOrderCtrl, PagedItem<AssignedOrder>> {
  /// See also [AssignOrderCtrl].
  AssignOrderCtrlProvider(
    String type,
  ) : this._internal(
          () => AssignOrderCtrl()..type = type,
          from: assignOrderCtrlProvider,
          name: r'assignOrderCtrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$assignOrderCtrlHash,
          dependencies: AssignOrderCtrlFamily._dependencies,
          allTransitiveDependencies:
              AssignOrderCtrlFamily._allTransitiveDependencies,
          type: type,
        );

  AssignOrderCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String type;

  @override
  FutureOr<PagedItem<AssignedOrder>> runNotifierBuild(
    covariant AssignOrderCtrl notifier,
  ) {
    return notifier.build(
      type,
    );
  }

  @override
  Override overrideWith(AssignOrderCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: AssignOrderCtrlProvider._internal(
        () => create()..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AssignOrderCtrl,
      PagedItem<AssignedOrder>> createElement() {
    return _AssignOrderCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssignOrderCtrlProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssignOrderCtrlRef
    on AutoDisposeAsyncNotifierProviderRef<PagedItem<AssignedOrder>> {
  /// The parameter `type` of this provider.
  String get type;
}

class _AssignOrderCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AssignOrderCtrl,
        PagedItem<AssignedOrder>> with AssignOrderCtrlRef {
  _AssignOrderCtrlProviderElement(super.provider);

  @override
  String get type => (origin as AssignOrderCtrlProvider).type;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
