import 'dart:io';

import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/profile_repo.dart';

part 'profile_ctrl.g.dart';

@riverpod
class ProfileCtrl extends _$ProfileCtrl {
  final _repo = locate<ProfileRepo>();

  Future<File?> picImage() async {
    final files = await locate<FilePickerRepo>().pickImageFromGallery();
    File? file;
    files.fold((l) => Toaster.showError(l), (r) => file = r);
    return file;
  }

  Future<void> updateProfile(QMap data, File? file) async {
    final form = {...data};
    if (file != null) {
      final part = await MultipartFile.fromFile(file.path);
      form['image'] = part;
    }
    final res = await _repo.updateProfile(form);
    res.fold(
      (l) => Toaster.showError(l),
      (r) {
        Toaster.showSuccess(r.data);
        ref.invalidate(homeCtrlProvider);
      },
    );
  }

  Future<void> updateActiveStatus(String status) async {
    final res = await _repo.activeStatus(status);
    await res.fold(
      (l) async => Toaster.showError(l),
      (r) async {
        await ref.read(homeCtrlProvider.notifier).reload();
      },
    );
  }

  Future<void> pushNotificationStatus(String status) async {
    final res = await _repo.pushNotificationStatus(status);
    res.fold(
      (l) => Toaster.showError(l),
      (r) => ref.invalidate(homeCtrlProvider),
    );
  }

  @override
  String build() {
    return '';
  }
}
