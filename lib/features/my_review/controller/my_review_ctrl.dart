import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/my_review_repo.dart';

part 'my_review_ctrl.g.dart';

@riverpod
class MyReviewCtrl extends _$MyReviewCtrl {
  final _repo = locate<ReviewRepo>();

  @override
  FutureOr<PagedItem<DeliveryManReview>> build() async {
    final homeData = await ref.refresh(homeCtrlProvider.future);
    return homeData.deliveryMan.reviews;
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> fromUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();

    final data = await _repo.getFromUrl(url);

    state = data.fold(
      (l) => l.toAsyncError(),
      (r) => AsyncData(r.data),
    );
  }
}
