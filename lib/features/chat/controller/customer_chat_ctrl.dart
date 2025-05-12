import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/chat_repo.dart';

part 'customer_chat_ctrl.g.dart';

@riverpod
class CustomerChatCtrl extends _$CustomerChatCtrl {
  final _repo = locate<ChatRepo>();

  Future<void> reload([bool silent = false]) async {
    if (!silent) state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  Future<void> deleteConversation(String id) async {
    final data = await _repo.deleteConversation(id);
    data.fold(
      (l) => Toaster.showError(l),
      (r) {
        Toaster.showSuccess(r.data);
        ref.invalidateSelf();
      },
    );
  }

  Future<void> search(String query) async {
    if (query.isEmpty) return ref.invalidateSelf();

    final it = await future;

    final list = it
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    state = AsyncValue.data(list);
  }

  @override
  Future<List<CustomerData>> build() async {
    final data = await _repo.fetchChatList();

    return data.fold((l) => l.toFError(), (r) => r.data);
  }
}

@riverpod
class CustomerMessageCtrl extends _$CustomerMessageCtrl {
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
        await _repo.loadMoreFromUrl(nextUrl, (x) => MessageModel.fromMap(x));
    final more = moreData.fold(
      (l) => it.messages,
      (r) => it.messages + r.data,
    );

    state = AsyncData(it.copyWith(messages: more));

    return moreData.fold((l) => LoadStatus.failed, (r) => LoadStatus.idle);
  }

  Future<void> reply(String msg, List<File> files) async {
    if (msg.isEmpty) {
      Toaster.showError('Please enter message');
      return;
    }
    final data = await _repo.sendReply(id: id, msg: msg, files: files);
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

  Future<CustomerChat> _init() async {
    final data = await _repo.fetchMessage(id);
    return data.fold((l) => l.toFError(), (r) => r.data);
  }

  @override
  Future<CustomerChat> build(String id) async {
    return _init();
  }
}
