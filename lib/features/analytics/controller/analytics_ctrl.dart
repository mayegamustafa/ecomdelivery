import 'package:delivery_boy/features/analytics/repository/analytics_repo.dart';
import 'package:delivery_boy/locator.dart';
import 'package:delivery_boy/models/analytics/analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'analytics_ctrl.g.dart';

@riverpod
class AnalyticsCtrl extends _$AnalyticsCtrl {
  final _repo = locate<AnalyticsRepo>();

  Future<void> reload([bool silent = false]) async {
    if (!silent) state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  @override
  FutureOr<AnalyticsModel> build() async {
    final data = await _repo.fetchAnalytics();
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
