import 'package:delivery_boy/features/referral/repository/referral_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'referral_ctrl.g.dart';

@riverpod
class ReferralCtrl extends _$ReferralCtrl {
  final _repo = locate<ReferralRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> updateReferralCode(
    String code,
  ) async {
    final res = await _repo.updateReferralCode(code);
    res.fold(
      (l) => Toaster.showError(l),
      (r) {
        Toaster.showSuccess(r.data);
      },
    );
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return ref.invalidateSelf();

    final it = await future;
    final deliveryMans = it.deliveryMen;

    final list = deliveryMans
        .where((e) => e.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    final copy = it.copyWith(deliveryMen: list);

    state = AsyncValue.data(copy);
  }

  @override
  FutureOr<ReferralLog> build() async {
    final data = await _repo.getReferralLog();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
