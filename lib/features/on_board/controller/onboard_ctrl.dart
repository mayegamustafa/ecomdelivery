import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/on_board_repo.dart';

part 'onboard_ctrl.g.dart';

@Riverpod(keepAlive: true)
class OnBoardCtrl extends _$OnBoardCtrl {
  final _repo = locate<OnboardRepo>();

  @override
  bool build() => _repo.showOnboard();

  Future<void> disableOnboard() async {
    await _repo.disableOnboard();
    ref.invalidateSelf();
  }
}
