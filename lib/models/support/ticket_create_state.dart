import 'dart:io' as io;

import 'package:dio/dio.dart';

class TicketCreateState {
  const TicketCreateState({
    required this.subject,
    required this.priority,
    required this.message,
    required this.files,
  });

  static const empty =
      TicketCreateState(subject: '', priority: '1', message: '', files: []);

  final List<io.File> files;
  final String message;
  final String priority;
  final String subject;

  TicketCreateState copyWith({
    String? subject,
    String? priority,
    String? message,
    List<io.File>? files,
  }) {
    return TicketCreateState(
      subject: subject ?? this.subject,
      priority: priority ?? this.priority,
      message: message ?? this.message,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject,
      'priority': priority,
      'message': message,
    };
  }

  Future<Map<String, dynamic>> toMapFiles() async {
    final fileParts = <MultipartFile>[];
    for (var img in files) {
      final file = await MultipartFile.fromFile(
        img.path,
        filename: img.path.split('/').last,
      );
      fileParts.add(file);
    }
    return <String, dynamic>{'file': fileParts};
  }
}
