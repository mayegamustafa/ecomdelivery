import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../main.export.dart';
import '../repository/redeem_points_repo.dart';
part 'redeem_points_ctrl.g.dart';

@riverpod
class RedeemPointsCtrl extends _$RedeemPointsCtrl {
  final _repo = locate<RedeemPointsRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> filter({DateTimeRange? range, String? search}) async {
    final data = await _repo.getRewordLog(search ?? '', range?.toQuery() ?? '');

    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  Future<void> redeemPoint() async {
    final data = await _repo.redeemPoint();
    data.fold(
      (l) => l.toAsyncError(),
      (r) {
        ref.read(homeCtrlProvider.notifier).reload();
        return Toaster.showSuccess(r.data);
      },
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
  FutureOr<PagedItem<RewardLogs>> build() async {
    final data = await _repo.getRewordLog();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
