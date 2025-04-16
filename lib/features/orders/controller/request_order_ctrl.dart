import 'package:delivery_boy/features/orders/repository/orders_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/models/home/assigned_order.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_order_ctrl.g.dart';

@riverpod
class RequestOrderCtrl extends _$RequestOrderCtrl {
  final _repo = locate<OrderRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> search(String query) async {
    final data = await _repo.getRequestOrder(query);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<ProductOrder>> build() async {
    final data = await _repo.getRequestOrder();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}

@riverpod
class AssignOrderCtrl extends _$AssignOrderCtrl {
  final _repo = locate<OrderRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> filter({String? search, DateTimeRange? date}) async {
    final data = await _repo.getAssignLog(
      search: search,
      date: date?.toQuery(),
      type: type,
    );
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> listByUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();
    final data = await _repo.assignUrl(url);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<AssignedOrder>> build(String type) async {
    final data = await _repo.getAssignLog(type: type);
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
