import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';

class ChatRepo extends Repo {
  //! deliveryman Chat

  FutureResponse<List<DeliveryMan>> fetchDeliveryManChatList() async {
    final data = await rdb.fetchDeliveryManChatList();
    return data;
  }

  FutureResponse<DeliveryManChat> fetchDeliveryManMessage(String id) async {
    final data = await rdb.fetchDeliveryManMessage(id);
    return data;
  }

  FutureResponse<String> sendReplyDeliveryman({
    required int id,
    required String msg,
    List<File> files = const [],
  }) async {
    final partFiles = <MultipartFile>[];

    for (var file in files) {
      partFiles.add(
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      );
    }

    final formData = {
      'delivery_man_id': id,
      'message': msg,
      'files': partFiles
    };

    final data = await rdb.sendDeliveryManMessage(formData);
    return data;
  }

  //! Customer Chat
  FutureResponse<CustomerChat> fetchMessage(String id) async {
    final data = await rdb.fetchChatMessage(id);
    return data;
  }

  FutureResponse<List<CustomerData>> fetchChatList() async {
    final data = await rdb.fetchChatList();
    return data;
  }

  FutureResponse<String> deleteConversation(String id) async {
    final data = await rdb.deleteConversation(id);
    return data;
  }

  FutureResponse<PagedItem<T>> loadMoreFromUrl<T>(
    String url,
    T Function(QMap map) mapper,
  ) async {
    final data = await rdb.pagedItemFromUrl(url, 'messages', mapper);
    return data;
  }

  FutureResponse<String> sendReply({
    required String id,
    required String msg,
    List<File> files = const [],
  }) async {
    final partFiles = <MultipartFile>[];

    for (var file in files) {
      partFiles.add(
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      );
    }

    final formData = {'customer_id': id, 'message': msg, 'files': partFiles};

    final data = await rdb.sendChatMessage(formData);
    return data;
  }
}
