import 'dart:async';
import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/ticket_repository.dart';

part 'ticket_massage_ctrl.g.dart';

@riverpod
class TicketMessageCtrl extends _$TicketMessageCtrl {
  final _repo = locate<TicketRepo>();

  Future<void> reload() async {
    state = const AsyncValue.loading();
    ref.invalidateSelf();
  }

  @override
  FutureOr<TicketData> build(String arg) async {
    final data = await _repo.getMassage(arg);
    return data.fold(
      (l) => l.toFError(),
      (r) => r.data,
    );
  }

  Future<void> ticketReply(String message, List<File> file) async {
    if (message.isEmpty) {
      Toaster.showError('Message field is required');
      return;
    }
    final res = await _repo.ticketReply(message, arg, file);
    res.fold(
      (l) {
        Toaster.showError(l);
        ref.invalidateSelf();
      },
      (r) => state = AsyncData(r.data),
    );
  }

  Future<List<File>> pickFiles() async {
    final picker = locate<FilePickerRepo>();
    const exts = null;
    // ref.read(localSettingsProvider.select((v) => v?.allFormate ?? []));
    final res = await picker.pickFiles(allowedExtensions: exts);

    return res.fold(
      (l) {
        Toaster.showError(l);
        return [];
      },
      (r) => r,
    );
  }
}

// Ticket Create Controller

@riverpod
class TicketCreateCtrl extends _$TicketCreateCtrl {
  final _repo = locate<TicketRepo>();

  void setTicketInfo(QMap map) {
    state = state.copyWith(
      subject: map['subject'],
      priority: map['priority'],
      message: map['message'],
    );
  }

  Future<void> pickFiles() async {
    final picker = locate<FilePickerRepo>();
    const exts = null;
    // ref.read(localSettingsProvider.select((v) => v?.allFormate ?? []));
    final res = await picker.pickFiles(allowedExtensions: exts);

    res.fold(
      (l) => Toaster.showError(l),
      (r) => state = state.copyWith(files: r),
    );
  }

  Future<void> removeFile(int index) async {
    state = state.copyWith(files: state.files..removeAt(index));
  }

  @override
  TicketCreateState build() {
    return TicketCreateState.empty;
  }

  Future<String?> createTicket() async {
    final parts = await state.toMapFiles();
    final formData = {...state.toMap(), ...parts};
    Logger.json(state.toMap());
    final res = await _repo.createTicket(formData);

    return res.fold((l) {
      Logger.ex(l.message, l.stackTrace);
      return null;
    }, (r) {
      return r.data.ticket.ticketNumber;
    });
  }
}
