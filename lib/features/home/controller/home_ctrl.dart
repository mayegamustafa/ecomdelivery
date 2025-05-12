import 'package:delivery_boy/features/home/repository/home_repo.dart';
import 'package:delivery_boy/features/region/controller/region_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_ctrl.g.dart';

@riverpod
class HomeCtrl extends _$HomeCtrl {
  final _repo = locate<HomeRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<HomeModel> _init() async {
    final data = await _repo.getHomeData();
    return data.fold(
      (l) => l.toFError(),
      (r) async {
        await ref.read(localHomeCtrlProvider.notifier).save(r.data);
        return r.data;
      },
    );
  }

  @override
  FutureOr<HomeModel> build() async {
    /// this is needed to rebuild this provider when region changes
    ref.watch(regionCtrlProvider.select((c) => c.currency));

    return _init();
  }
}

@riverpod
class LocalHomeCtrl extends _$LocalHomeCtrl {
  final _repo = locate<HomeRepo>();

  Future<void> save(HomeModel home) async {
    state = await _repo.saveHomeData(home);
    ref.invalidateSelf();
  }

  @override
  HomeModel? build() {
    final data = _repo.getHomeDataSync();
    return data;
  }
}
