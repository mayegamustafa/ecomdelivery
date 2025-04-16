import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/orders/repository/orders_repo.dart';
import 'package:delivery_boy/features/region/controller/region_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_ctrl.g.dart';

@riverpod
class OrderListCtrl extends _$OrderListCtrl {
  final _repo = locate<OrderRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> fromUrl(String? url) async {
    if (url == null) return;
    _repo.fromUrl(url);
    await reload();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return reload();

    state = const AsyncValue.loading();
    final data = await _repo.getOrders(status: status, search: query);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> filterByDate(DateTimeRange? date) async {
    state = const AsyncValue.loading();
    final data = await _repo.getOrders(status: status, date: date?.toQuery());
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<ProductOrder>> build(String? status) async {
    /// this is needed to rebuild this provider when region changes
    ref.watch(regionCtrlProvider.select((s) => s.currency));

    final data = await _repo.getOrders(status: status);
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}

@riverpod
class OrderCtrl extends _$OrderCtrl {
  final _repo = locate<OrderRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> requestOrder({
    required String status,
    required String id,
    required String note,
  }) async {
    final res = await _repo.requestOrder(status: status, id: id, note: note);
    res.fold(
      (l) => Toaster.showError(l),
      (r) {
        Toaster.showSuccess(r.data);
        ref.invalidate(homeCtrlProvider);
      },
    );
  }

  Future<bool> handleOrder({
    required String status,
    required String id,
    required QMap formData,
  }) async {
    final res = await _repo.handleOrder(
      status: status,
      id: id,
      formData: formData,
    );
    return res.fold(
      (l) => Toaster.showError(l).andReturn(false),
      (r) => Toaster.showSuccess(r.data).andReturn(true),
    );
  }

  Future<void> assignOrder({
    required QMap formData,
    required String id,
    required String deliverymanID,
  }) async {
    final res = await _repo.assignOrder(
      id: id,
      deliverymanID: deliverymanID,
      formData: formData,
    );
    res.fold(
      (l) => Toaster.showError(l),
      (r) {
        Toaster.showSuccess(r.data);
        ref.invalidateSelf();
      },
    );
  }

  @override
  FutureOr<ProductOrder> build(String orderId) async {
    final data = await _repo.getOrderDetails(orderId);
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}

@riverpod
class DeliveryManCtrl extends _$DeliveryManCtrl {
  final _repo = locate<OrderRepo>();

  Future<void> reload([bool silent = false]) async {
    if (!silent) state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return ref.invalidateSelf();

    final it = await future;

    final list = it
        .where((e) => e.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = AsyncValue.data(list);
  }

  @override
  FutureOr<List<DeliveryMan>> build() async {
    final data = await _repo.getDeliveryman();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
