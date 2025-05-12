import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

class FilePickerRepo {
  final _picker = FilePicker.platform;

  FutureReport<File> pickImageFromGallery() async {
    FilePickerResult? result = await _picker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'jfif', 'webp', 'heif'],
    );

    try {
      if (result == null) {
        return left(const Failure('No img selected'));
      }
      final file = File(result.files.single.path!);

      Logger(file.path);
      return right(file);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureReport<List<File>> pickFiles({
    List<String>? allowedExtensions,
    FileType type = FileType.any,
  }) async {
    try {
      FilePickerResult? result = await _picker.pickFiles(
        type: allowedExtensions == null ? type : FileType.custom,
        allowMultiple: true,
        allowedExtensions: allowedExtensions,
      );

      if (result == null) {
        return left(const Failure('No file selected'));
      }

      final file = result.files.map((e) => File(e.path!)).toList();
      return right(file);
    } on PlatformException catch (e) {
      return left(Failure(e.message.toString()));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureReport<File> pickFile({
    List<String>? allowedEx,
    FileType type = FileType.any,
  }) async {
    try {
      final t =
          (allowedEx == null || allowedEx.isEmpty) ? type : FileType.custom;

      FilePickerResult? result = await _picker.pickFiles(
        type: t,
        allowedExtensions: allowedEx,
      );

      if (result == null) {
        return left(const Failure('No file selected'));
      }

      final file = result.files.firstOrNull;
      if (file == null) return left(const Failure('No file selected'));

      return right(File(file.path!));
    } on PlatformException catch (e) {
      return left(Failure(e.message.toString()));
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
