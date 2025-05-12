import 'package:delivery_boy/main.export.dart';

class WithdrawRepo extends Repo {
  FutureResponse<List<WithdrawMethod>> getMethods() async {
    final data = await rdb.fetchWithdrawMethods();
    return data;
  }

  FutureResponse<PagedItem<WithdrawData>> getWithdrawList([
    String search = '',
    String date = '',
  ]) async {
    final data = await rdb.fetchWithdrawList(search: search, date: date);
    return data;
  }

  FutureResponse<PagedItem<WithdrawData>> getFromUrl(
    String url,
  ) async {
    final data =
        await rdb.pagedItemFromUrl(url, 'withdraw_list', WithdrawData.fromMap);
    return data;
  }

  FutureReport<BaseResponse<({String msg, WithdrawData data})>> request(
    String id,
    String amount,
  ) async {
    final data = await rdb.requestWithdraw(methodId: id, amount: amount);
    return data;
  }

  FutureReport<BaseResponse<String>> storeWithdraw(
    String id,
    QMap formData,
  ) async {
    final data = await rdb.storeWithdraw(id: id, formData: formData);
    return data;
  }
}
