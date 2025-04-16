import 'dart:async';

import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/ticket_repository.dart';

part 'ticket_ctrl.g.dart';

@riverpod
class TicketListCtrl extends _$TicketListCtrl {
  final _repo = locate<TicketRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> search(String query) async {
    final data = await _repo.getTickets(null, query);
    state = data.fold(
      (l) => l.toAsyncError(),
      (r) => AsyncValue.data(r.data),
    );
  }

  Future<void> listByUrl(String? url) async {
    if (url == null) return;
    state = const AsyncValue.loading();
    final data = await _repo.getTickets(url);
    data.fold(
      (l) => state = l.toAsyncError(),
      (r) => state = AsyncData(r.data),
    );
  }

  @override
  FutureOr<PagedItem<SupportTicket>> build() async {
    final data = await _repo.getTickets();
    return data.fold(
      (l) => l.toFError(),
      (r) => r.data,
    );
  }
}
