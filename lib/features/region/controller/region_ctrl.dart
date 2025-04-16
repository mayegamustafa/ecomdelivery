import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/region_repo.dart';

part 'region_ctrl.g.dart';

@riverpod
class RegionCtrl extends _$RegionCtrl {
  final _repo = locate<RegionRepo>();

  @override
  Region build() {
    return _repo.getRegion();
  }

  Future<void> setLanguage(String langCode) async {
    final region = state.copyWith(langCode: langCode);
    _repo.setLanguage(langCode);
    state = region;
  }

  Future<void> setCurrency(Currency currency) async {
    final region = state.copyWith(currency: currency);
    _repo.setCurrency(currency);
    state = region;
  }
}
