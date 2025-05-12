import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../main.export.dart';
import '../repository/chat_repo.dart';

part 'deliveryman_chat_ctrl.g.dart';

@riverpod
class DeliveryManChatCtrl extends _$DeliveryManChatCtrl {
  final _repo = locate<ChatRepo>();

  Future<void> reload([bool silent = false]) async {
    if (!silent) state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return ref.invalidateSelf();

    query = query.toLowerCase().trim();
    final isEmail = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(query);

    final it = await future;

    final list = it.filter(
      (e) {
        final s = isEmail ? e.email : e.fullName;
        return s.toLowerCase().contains(query);
      },
    ).toList();

    state = AsyncValue.data(list);
  }

  @override
  FutureOr<List<DeliveryMan>> build() async {
    final data = await _repo.fetchDeliveryManChatList();
    return data.fold(
      (l) => l.toFError(),
      (r) => r.data,
    );
  }
}

@riverpod
class DeliveryManChatMessageCtrl extends _$DeliveryManChatMessageCtrl {
  final _repo = locate<ChatRepo>();

  Future<void> reload() async {
    final data = await _init();
    state = AsyncData(data);
  }

  Future<LoadStatus> loadMore() async {
    final it = await future;
    final nextUrl = it.messages.pagination?.nextPageUrl;
    if (nextUrl == null) return LoadStatus.noMore;

    final moreData =
        await _repo.loadMoreFromUrl(nextUrl, (m) => DeliveryMessage.fromMap(m));
    final more = moreData.fold(
      (l) => it.messages,
      (r) => it.messages + r.data,
    );

    state = AsyncData(it.copyWith(messages: more));

    return moreData.fold((l) => LoadStatus.failed, (r) => LoadStatus.idle);
  }

  Future<void> replyChat(String msg, List<File> files) async {
    if (msg.isEmpty) {
      Toaster.showError('Please enter message');
      return;
    }
    final current = await future;

    final data = await _repo.sendReplyDeliveryman(
        id: current.deliveryMan.id, msg: msg, files: files);
    data.fold(
      (l) => Toaster.showError(l),
      (r) => ref.invalidateSelf(),
    );
  }

  Future<List<File>> pickFiles() async {
    final newFiles = await locate<FilePickerRepo>().pickFiles();

    return newFiles.fold(
      (l) => Toaster.showError(l).andReturn([]),
      (r) => r,
    );
  }

  @override
  Future<DeliveryManChat> build(String id) async {
    return _init();
  }

  Future<DeliveryManChat> _init() async {
    final data = await _repo.fetchDeliveryManMessage(id);
    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}
