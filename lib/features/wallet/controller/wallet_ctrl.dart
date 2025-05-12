import 'package:delivery_boy/features/wallet/repository/wallet_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wallet_ctrl.g.dart';

@riverpod
Future<List<WithdrawMethod>> withdrawMethods(WithdrawMethodsRef ref) async {
  final data = await locate<WithdrawRepo>().getMethods();

  return data.fold((l) => l.toFError(), (r) => r.data);
}

@riverpod
class WithDrawListCtrl extends _$WithDrawListCtrl {
  final _repo = locate<WithdrawRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> filter({DateTimeRange? range, String? search}) async {
    final data =
        await _repo.getWithdrawList(search ?? '', range?.toQuery() ?? '');

    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> search(String query) async {
    final data = await _repo.getWithdrawList(query);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> filterByDate(DateTimeRange? range) async {
    final data = await _repo.getWithdrawList('', range.toQuery());
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> listByUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();
    final data = await _repo.getFromUrl(url);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<WithdrawData>> build() async {
    final data = await _repo.getWithdrawList();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
