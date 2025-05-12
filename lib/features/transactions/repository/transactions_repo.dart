import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class TransactionRepo extends Repo {
  FutureResponse<PagedItem<TransactionData>> transactionList({
    DateTimeRange? dateRange,
    String search = '',
  }) async {
    final data = await rdb.fetchTransactions(search, dateRange.toQuery());
    return data;
  }

  FutureResponse<PagedItem<TransactionData>> fromUrl(String url) async {
    final data = await rdb.pagedItemFromUrl(
      url,
      'transactions',
      (x) => TransactionData.fromMap(x),
    );
    return data;
  }
}
