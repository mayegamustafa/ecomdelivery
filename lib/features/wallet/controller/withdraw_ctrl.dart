import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/wallet/controller/wallet_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/wallet_repo.dart';

part 'withdraw_ctrl.g.dart';

@riverpod
class WithdrawCtrl extends _$WithdrawCtrl {
  final _repo = locate<WithdrawRepo>();

  @override
  WithdrawData? build() {
    return null;
  }

  Future<bool> request(String id, String amount) async {
    ref.keepAlive();
    final data = await _repo.request(id, amount);

    data.fold(
      (l) => Toaster.showError(l),
      (r) {
        state = r.data.data;
        Toaster.showSuccess(r.data.msg);
      },
    );

    return data.isRight();
  }

  Future<bool> store(String id, QMap formData) async {
    final data = await _repo.storeWithdraw(id, formData);

    return data.fold(
      (l) => Toaster.showError(l).andReturn(false),
      (r) {
        ref.invalidateSelf();
        ref.invalidate(withDrawListCtrlProvider);
        ref.invalidate(homeCtrlProvider);
        return Toaster.showSuccess(r.data).andReturn(true);
      },
    );
  }
}
