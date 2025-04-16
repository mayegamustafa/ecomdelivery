import 'dart:io';

import 'package:delivery_boy/main.export.dart';

class TicketRepo extends Repo {
  FutureResponse<PagedItem<SupportTicket>> getTickets([
    String? url,
    String? search,
  ]) async {
    final data = await rdb.fetchTicketList(url, search);
    return data;
  }

  FutureResponse<TicketData> getMassage(String id) async {
    final data = await rdb.ticketMessage(id);
    return data;
  }

  FutureResponse<TicketData> ticketReply(
    String message,
    String ticketNumber,
    List<File> file,
  ) async {
    final data = await rdb.ticketMessageReply(
      ticketNumber: ticketNumber,
      message: message,
      files: file,
    );
    return data;
  }

  FutureResponse<TicketData> createTicket(QMap formData) async {
    final data = await rdb.createTicket(formData);
    return data;
  }

  FutureResponse<String> fileDownload({
    required String id,
    required String massageId,
    required String ticketNo,
  }) async {
    final data = await rdb.ticketDownloadFile(
      id: id,
      massageId: massageId,
      ticketNo: ticketNo,
    );
    return data;
  }
}
