import 'package:delivery_boy/features/auth/repository/auth_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_reset_ctrl.g.dart';

@Riverpod(keepAlive: true)
class PasswordResetCtrl extends _$PasswordResetCtrl {
  final _repo = locate<AuthRepo>();

  void copyWithMap(QMap formData) => state = state.copyWithMap(formData);

  Future<bool> verifyPhone() async {
    final data = await _repo.verifyPhone(state.toMap());
    return data.fold(
      (l) => Toaster.showError(l).andReturn(false),
      (r) => Toaster.showSuccess(r.data).andReturn(true),
    );
  }

  Future<bool> verifyOtp() async {
    final data = await _repo.verifyOTP(state.toMap());
    return data.fold(
      (l) => Toaster.showError(l).andReturn(false),
      (r) => Toaster.showSuccess(r.data).andReturn(true),
    );
  }

  Future<bool> resetPass() async {
    final data = await _repo.resetPassword(state.toMap());
    return data.fold(
      (l) => Toaster.showError(l).andReturn(false),
      (r) => Toaster.showSuccess(r.data).andReturn(true),
    );
  }

  @override
  PassResetState build() {
    return PassResetState.empty;
  }
}
