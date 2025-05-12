import 'package:delivery_boy/features/region/controller/region_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/transactions_repo.dart';

part 'transactions_ctrl.g.dart';

@riverpod
class TransactionsCtrl extends _$TransactionsCtrl {
  final _repo = locate<TransactionRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> filter({DateTimeRange? dateRange, String? search}) async {
    final data =
        await _repo.transactionList(dateRange: dateRange, search: search ?? '');

    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> listByUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();
    final data = await _repo.fromUrl(url);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<TransactionData>> build() async {
    /// this is needed to rebuild this provider when region changes
    ref.watch(regionCtrlProvider);

    final data = await _repo.transactionList();

    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
