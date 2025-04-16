import 'dart:async';
import 'dart:io';

import 'package:delivery_boy/features/auth/repository/auth_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_ctrl.g.dart';

@Riverpod(keepAlive: true)
class AuthCtrl extends _$AuthCtrl {
  final _repo = locate<AuthRepo>();

  @override
  bool build() {
    Logger('auth init', 'AuthCtrl');
    final loggedIn = _repo.getToken();
    final isLoggedIn = loggedIn != null;
    Logger(isLoggedIn, 'isLoggedIn');
    unawaited(_setupFireMsg(isLoggedIn));
    return isLoggedIn;
  }

  Future<void> registration(QMap data, File? file) async {
    final form = {...data};
    if (file != null) {
      final part = await MultipartFile.fromFile(file.path);
      form['image'] = part;
    }
    final res = await _repo.registration(form.removeNullAndEmpty());
    res.fold(
      (l) => Toaster.showError(l),
      (r) async {
        await _repo.saveToken(r.data);
        Toaster.showSuccess('Registration Successful');
        ref.invalidateSelf();
      },
    );
  }

  Future<File?> picImage() async {
    final files = await locate<FilePickerRepo>().pickImageFromGallery();
    File? file;
    files.fold((l) => Toaster.showError(l), (r) => file = r);
    return file;
  }

  Future<void> _setupFireMsg(bool isLoggedIn) async {
    final fcm = FireMessage.instance;
    await fcm?.updateServerToken(isLoggedIn);
  }

  Future<void> login(QMap formData) async {
    final data = await _repo.login(formData);
    data.fold(
      (l) => Toaster.showError(l),
      (r) async {
        await _repo.saveToken(r.data);
        Toaster.showSuccess('Login Successful');
        ref.invalidateSelf();
      },
    );
  }

  Future<void> updatePassword(QMap formData) async {
    final data = await _repo.updatePassword(formData);
    data.fold(
      (l) => Toaster.showError(l),
      (r) => Toaster.showSuccess(r.data),
    );
    ref.invalidateSelf();
  }

  Future<void> logout([bool callApi = true]) async {
    if (callApi) {
      final data = await _repo.logOut();
      data.fold(
        (l) => Toaster.showError(l),
        (r) => Toaster.showSuccess(r.data),
      );
    } else {
      await _repo.deleteToken();
    }
    ref.invalidateSelf();
  }
}
