import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/statement_repo.dart';

part 'statement_ctrl.g.dart';

@riverpod
class StatementCtrl extends _$StatementCtrl {
  final _repo = locate<EarningRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> fromUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();
    final data = await _repo.fromUrl(url);
    state = data.fold((l) => l.toAsyncError(), (r) => AsyncData(r.data));
  }

  @override
  FutureOr<PagedItem<EarningData>> build() async {
    final data = await _repo.earningLogs();

    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
